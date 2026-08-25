import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8080/api"; // For Android Emulator
  // static const String baseUrl = "http://localhost:8080/api";

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = await _getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse("$baseUrl$endpoint");
    final headers = await _getHeaders();
    return await http.get(url, headers: headers);
  }

  Future<http.Response> post(String endpoint, dynamic body) async {
    final url = Uri.parse("$baseUrl$endpoint");
    final headers = await _getHeaders();
    return await http.post(url, headers: headers, body: jsonEncode(body));
  }

  Future<http.StreamedResponse> postMultipart(String endpoint, Map<String, String> fields, File? imageFile) async {
    final url = Uri.parse("$baseUrl$endpoint");
    final token = await _getToken();
    var request = http.MultipartRequest('POST', url);
    
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    request.fields.addAll(fields);

    if (imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
        contentType: MediaType('image', 'jpeg'), // Or detect dynamically
      ));
    }

    return await request.send();
  }

  Future<http.Response> put(String endpoint, dynamic body) async {
    final url = Uri.parse("$baseUrl$endpoint");
    final headers = await _getHeaders();
    return await http.put(url, headers: headers, body: jsonEncode(body));
  }

  Future<http.Response> delete(String endpoint) async {
    final url = Uri.parse("$baseUrl$endpoint");
    final headers = await _getHeaders();
    return await http.delete(url, headers: headers);
  }
}
