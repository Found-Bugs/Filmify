import 'dart:convert';
import 'dart:io';
import 'package:filmify/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:filmify/services/cloudinary_service.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  bool _isCameraInitialized = false;
  int _selectedCameraIndex = 0;
  String? _imagePath;
  bool _isUploading = false;
  String? _uploadedImageUrl;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) throw Exception("Kamera tidak ditemukan");

      _cameraController = CameraController(
        _cameras[_selectedCameraIndex],
        ResolutionPreset.high,
      );

      await _cameraController.initialize();

      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menginisialisasi kamera: $e")),
      );
    }
  }

  Future<void> _switchCamera() async {
    if (_cameras.length > 1) {
      try {
        await _cameraController.dispose();

        setState(() {
          _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;
          _isCameraInitialized = false;
        });

        _cameraController = CameraController(
          _cameras[_selectedCameraIndex],
          ResolutionPreset.high,
        );

        await _cameraController.initialize();

        setState(() {
          _isCameraInitialized = true;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal mengganti kamera: $e")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hanya satu kamera tersedia')),
      );
    }
  }

  Future<void> _takePicture() async {
    try {
      final image = await _cameraController.takePicture();
      final directory = await getApplicationDocumentsDirectory();
      final imagePath =
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final imageFile = File(imagePath);
      await image.saveTo(imageFile.path);

      setState(() {
        _imagePath = imagePath;
      });

      await _uploadImage(); // Upload image immediately after taking picture
    } catch (e) {
      print('Error mengambil gambar: $e');
    }
  }

  Future<void> _uploadImage() async {
    if (_imagePath != null) {
      setState(() {
        _isUploading = true;
      });

      final imageFile = File(_imagePath!);
      final cloudinaryService = CloudinaryService();
      final imageUrl = await cloudinaryService.uploadImage(imageFile);

      setState(() {
        _isUploading = false;
        _uploadedImageUrl = imageUrl;
      });

      if (imageUrl != null) {
        await _processImage(imageUrl);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Gagal mengunggah gambar',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      }
    }
  }

  Future<void> _processImage(String imageUrl) async {
    final response = await http.post(
      Uri.parse('https://bcf4-182-253-176-146.ngrok-free.app/predict/url/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'image_url': imageUrl}),
    );

    if (response.statusCode == 200) {
      final prediction = jsonDecode(response.body)['prediction'];
      _showPredictionDialog(prediction);

      // Save prediction and image URL to Firestore
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final authService = AuthService();
        await authService.savePredictionToHistory(user.uid, imageUrl, prediction);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memproses gambar: ${response.body}')),
      );
    }
  }

  void _showPredictionDialog(Map<String, dynamic> prediction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Prediksi Ekspresi Wajah'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Expression: ${prediction['predicted_class']}'),
              Text('Result: ${(prediction['confidence'] * 100).toStringAsFixed(2)}%'),
              // Display confidence scores for each class
              ...prediction['confidence_scores'].entries.map((entry) {
                return Text('${entry.key}: ${(entry.value * 100).toStringAsFixed(2)}%');
              }).toList(),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Oke'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          if (_uploadedImageUrl == null)
            CameraPreview(_cameraController)
          else
            Image.network(_uploadedImageUrl!),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 200,
              height: 300,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.white, width: 2),
                          left: BorderSide(color: Colors.white, width: 2),
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.white, width: 2),
                          right: BorderSide(color: Colors.white, width: 2),
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.white, width: 2),
                          left: BorderSide(color: Colors.white, width: 2),
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.white, width: 2),
                          right: BorderSide(color: Colors.white, width: 2),
                        ),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  GestureDetector(
                    onTap: _takePicture,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: const Icon(Icons.camera_alt,
                          size: 36, color: Colors.black),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.cameraswitch, color: Colors.black),
                    onPressed: _switchCamera,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
