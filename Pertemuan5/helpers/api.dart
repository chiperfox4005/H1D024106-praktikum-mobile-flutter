
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_info.dart';
import 'app_exception.dart';

class Api {
  final UserInfo userInfo = UserInfo();

  Future<Map<String, String>> getHeaders() async {
    String? token = await userInfo.getToken();

    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  dynamic _processResponse(http.Response response) {
    dynamic data;

    try {
      data = json.decode(response.body);
    } catch (_) {
      throw FetchDataException('Respons server tidak valid');
    }

    switch (response.statusCode) {
      case 200:
      case 201:
        return data;
      case 400:
        throw BadRequestException('Permintaan tidak valid');
      case 401:
        throw UnauthorisedException('Akses tidak diizinkan');
      case 404:
        throw NotFoundException('Data tidak ditemukan');
      default:
        throw FetchDataException(
          'Terjadi kesalahan server: ${response.statusCode}',
        );
    }
  }

  Future<dynamic> get(String url) async {
    final response = await http.get(
      Uri.parse(url),
      headers: await getHeaders(),
    );
    return _processResponse(response);
  }

  Future<dynamic> post(String url, dynamic data) async {
    final response = await http.post(
      Uri.parse(url),
      headers: await getHeaders(),
      body: json.encode(data),
    );
    return _processResponse(response);
  }

  Future<dynamic> put(String url, dynamic data) async {
    final response = await http.put(
      Uri.parse(url),
      headers: await getHeaders(),
      body: json.encode(data),
    );
    return _processResponse(response);
  }

  Future<dynamic> delete(String url) async {
    final response = await http.delete(
      Uri.parse(url),
      headers: await getHeaders(),
    );
    return _processResponse(response);
  }
}
