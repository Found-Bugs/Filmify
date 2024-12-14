import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:filmify/services/cloudinary_service.dart';
import 'dart:math' as math;

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
  String? _prediction;

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
      });

      if (imageUrl != null) {
        _showUploadSuccessDialog(imageUrl);
        await _sendImageUrlToFastAPI(imageUrl);
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

  Future<void> _sendImageUrlToFastAPI(String imageUrl) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/predict/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'image_url': imageUrl,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _prediction = data['prediction']['predicted_class'];
      });
    } else {
      throw Exception('Failed to get prediction');
    }
  }

  void _showUploadSuccessDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              Colors.transparent, // Make the AlertDialog background transparent
          contentPadding: EdgeInsets.zero, // Remove default padding
          content: ClipRRect(
            borderRadius: BorderRadius.circular(20.0), // Set the border radius
            child: Container(
              color: Colors.green, // Set the background color to green
              padding: const EdgeInsets.all(16.0), // Add padding inside the container
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'UPLOAD BERHASIL',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors
                          .white, // Set text color to white for better contrast
                    ),
                  ),
                  SizedBox(
                      height:
                          8.0), // Add some space between the title and content
                  Text(
                    'GAMBAR BERHASIL DIUNGGAH',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors
                          .white, // Set text color to white for better contrast
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    // Automatically close the dialog and navigate back to home after a delay
    Future.delayed(const Duration(milliseconds: 1700), () {
      Navigator.of(context).pop(); // Close the dialog
      Navigator.of(context).pop(); // Navigate back to home
    });
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
          if (_imagePath == null)
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(
                  _cameras[_selectedCameraIndex].lensDirection ==
                          CameraLensDirection.front
                      ? math.pi
                      : 0),
              child: CameraPreview(_cameraController),
            )
          else
            Image.file(File(_imagePath!)),
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
                  if (_imagePath == null)
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
                    )
                  else
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _imagePath = null;
                            });
                          },
                          child: const Text('Retake'),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: _uploadImage,
                          child: _isUploading
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : const Text('Upload'),
                        ),
                      ],
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
