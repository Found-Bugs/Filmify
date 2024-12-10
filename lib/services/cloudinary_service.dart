import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class CloudinaryService {
  final String cloudName = 'dtm0dq4oz';
  final String apiKey = '469335533621271';
  final String apiSecret = 'UlgoGrLiS70x6Mw3mqH8cHiG8Wg';
  final String uploadPreset =
      'ml_default'; // Update this with your actual upload preset

  Future<String?> uploadImage(File imageFile) async {
    final url =
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
    final mimeType = imageFile.path.split('.').last;

    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..fields['api_key'] = apiKey
      ..fields['timestamp'] = DateTime.now().millisecondsSinceEpoch.toString()
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path,
          contentType: MediaType('image', mimeType)));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseData);
        return jsonResponse['secure_url'];
      } else {
        final responseData = await response.stream.bytesToString();
        print('Failed to upload image: ${response.statusCode}');
        print('Response: $responseData');
        return null;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
