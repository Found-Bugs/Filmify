import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// Pastikan path ini benar

class CloudinaryService {
  final String cloudName = 'dtm0dq4oz';
  final String apiKey = '469335533621271';
  final String apiSecret = 'UlgoGrLiS70x6Mw3mqH8cHiG8Wg';

  Future<String?> uploadImage(File imageFile) async {
    final url =
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
    final mimeType = imageFile.path.split('.').last;

    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = 'ml_default'
      ..fields['api_key'] = apiKey
      ..fields['timestamp'] = DateTime.now().millisecondsSinceEpoch.toString()
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path,
          contentType: MediaType('image', mimeType)));

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final jsonResponse = json.decode(responseData);
      return jsonResponse['secure_url'];
    } else {
      print('Failed to upload image: ${response.statusCode}');
      return null;
    }
  }
}

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

      // Unggah gambar ke Cloudinary
      final cloudinaryService = CloudinaryService();
      final imageUrl = await cloudinaryService.uploadImage(imageFile);

      if (imageUrl != null) {
        print('Gambar berhasil diunggah: $imageUrl');
      } else {
        print('Gagal mengunggah gambar');
      }
    } catch (e) {
      print('Error mengambil gambar: $e');
    }
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
          CameraPreview(_cameraController),
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
