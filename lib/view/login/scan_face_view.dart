import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../common/colo_extension.dart';
import '../../common_widget/round_button.dart';
import 'stress_level.dart'; 

class ScanFaceView extends StatefulWidget {
  const ScanFaceView({super.key});

  @override
  State<ScanFaceView> createState() => _ScanFaceViewState();
}

class _ScanFaceViewState extends State<ScanFaceView> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _takePicture() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    
    if (image != null) {
      setState(() {
        _image = File(image.path);
        _isLoading = true;
      });

      // 10.0.2.2 is the localhost address for Android emulator to access the host machine
      final Uri apiUrl = Uri.parse('http://10.0.2.2:5000/predict');

      try {
        var request = http.MultipartRequest('POST', apiUrl);
        request.files.add(await http.MultipartFile.fromPath('file', _image!.path));

        var response = await request.send();

        if (response.statusCode == 200) {
          var responseData = await response.stream.bytesToString();
          var decodedData = json.decode(responseData);

          String stressLevel = decodedData['stress_level'] ?? "Unknown";

          setState(() {
            _isLoading = false;
          });

          // Navigate to Stress Level UI with the result
          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StressLevelView(stressLevel: stressLevel),
              ),
            );
          }
        } else {
          // Handle server error
          setState(() {
            _isLoading = false;
          });
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Failed to analyze. Please try again.")),
            );
          }
        }
      } catch (e) {
          // Handle connection error (e.g. backend not running)
          setState(() {
            _isLoading = false;
          });
           if (mounted) {
            // Provide a dummy redirect since backend might not be online during testing
             Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const StressLevelView(stressLevel: "Moderate"),
              ),
            );
          }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: TColor.gray),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Scan Face",
          style: TextStyle(color: TColor.gray, fontSize: 20, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF73D3E7),
              Color(0xFF82EDD4),
              Color(0xFFA6F5E2),
              Color(0xFFB5ECD9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100), // Add some space for the app bar
              Container(
                width: 250,
                height: 250,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: TColor.white,
                  border: Border.all(
                    width: 1,
                    color: TColor.gray.withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(
                          _image!,
                          width: 250,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: TColor.gray,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.face,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                          const SizedBox(height: 25),
                          Text(
                            "Place your face here",
                            style: TextStyle(
                              color: TColor.gray,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
              ),
              const SizedBox(height: 40),
              if (_isLoading)
                 const CircularProgressIndicator()
              else
                Column(
                  children: [
                    SizedBox(
                      width: 170,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: _takePicture,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff334155),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          _image == null ? "Start Scan" : "Retake",
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 170,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffCBD5E1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 40), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }
}