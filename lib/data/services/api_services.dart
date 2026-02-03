import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';

class ApiService {
  Future<dynamic> get(String endpoint) async {
    final uri = Uri.parse(endpoint);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error');
    }
  }

  Future<List<dynamic>> fetchProducts({required int limit}) async {
    return await get(ApiConstants.products);
  }

  Future<Map<String, dynamic>> fetchProductById(int id) async {
    return await get('${ApiConstants.products}/$id');
  }
}
