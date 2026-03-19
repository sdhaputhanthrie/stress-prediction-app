import os
import io
import numpy as np
from flask import Flask, request, jsonify
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing.image import load_img, img_to_array
from tensorflow.keras.applications.resnet import preprocess_input as resnet_preprocess

# Initialize Flask app
app = Flask(__name__)

# Constants
MODEL_PATH = "stress_model_resnet.h5"
IMG_SIZE = (180, 180)
# Target output classes
CLASSES = ["Severe", "Moderate", "Mild"]

# Global variable to hold the model
model = None

def get_model():
    """Load the model exactly once"""
    global model
    if model is None:
        if os.path.exists(MODEL_PATH):
            try:
                model = load_model(MODEL_PATH)
                print("Model loaded successfully.")
            except Exception as e:
                print(f"Error loading model: {e}")
        else:
            print(f"Warning: Model file '{MODEL_PATH}' not found in the current directory.")
            # The app will still start, but /predict will fail gracefully.
    return model

# Do an initial attempt to load the model on startup
get_model()

def prepare_image(image_bytes):
    """Process the image bytes to a numpy array for the model"""
    # Load image from bytes, resizing it to the required size
    img = load_img(io.BytesIO(image_bytes), target_size=IMG_SIZE)
    # Convert PIL Image to numpy array
    img_array = img_to_array(img)
    # Add batch dimension (i.e. shape becomes (1, 180, 180, 3))
    img_array = np.expand_dims(img_array, axis=0)
    # Normalize the pixel values (assuming standard 0-1 normalization for ResNet)
    img_array = img_array / 255.0
    return img_array

@app.route('/predict', methods=['POST'])
def predict():
    print(f"DEBUG: Predict request received at {request.url}")
    # Ensure the model is loaded first
    local_model = get_model()
    if local_model is None:
         print("DEBUG: Model loading failed inside /predict")
         return jsonify({"error": f"Model file '{MODEL_PATH}' not available. Please ensure it is placed in the server directory."}), 503

    # Check if a file was actually sent in the request
    if 'file' not in request.files:
        print(f"DEBUG: No file in request. Files: {list(request.files.keys())}")
        return jsonify({"error": "No file part in the request"}), 400

    file = request.files['file']

    if file.filename == '':
        return jsonify({"error": "No file selected for uploading"}), 400

    if file:
        try:
            # Read the file contents
            image_bytes = file.read()
            
            # Prepare the image as raw pixels (0-255) as seen in Dasun's training notebooks
            img = load_img(io.BytesIO(image_bytes), target_size=IMG_SIZE)
            img_array = img_to_array(img)
            img_batch = np.expand_dims(img_array, axis=0)
            
            # Raw model output
            raw_predictions = local_model.predict(img_batch, verbose=0)[0]
            print(f"DEBUG: Raw model scores: {raw_predictions}")
            
            # --- Bias Correction (Tuning) ---
            # The model is heavily biased towards 'Mild' (Index 2).
            # We apply weights to make it more sensitive to 'Moderate' and 'Severe'.
            weights = np.array([2.5, 1.5, 1.0]) # Weights for [Severe, Moderate, Mild]
            weighted_scores = raw_predictions * weights
            
            # Re-normalize to get a pseudo-probability for display
            final_scores = weighted_scores / np.sum(weighted_scores)
            print(f"DEBUG: Tuned scores: {final_scores}")
            
            predicted_class_idx = np.argmax(final_scores)
            predicted_class_name = CLASSES[predicted_class_idx]
            
            # Build the response
            response = {
                "stress_level": predicted_class_name,
                "confidence": float(final_scores[predicted_class_idx]),
                "raw_scores": raw_predictions.tolist() # Keep raw scores for debugging
            }
            
            return jsonify(response), 200

        except Exception as e:
            return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    # Run the app. 
    #host='0.0.0.0' allows external devices (like an Android emulator) to access it
    app.run(host='0.0.0.0', port=5000, debug=True)
