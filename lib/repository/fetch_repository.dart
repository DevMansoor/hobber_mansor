import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/get_model.dart';

class FetchRepository {
  Future<List<GetModel>> fetchData(String email) async {
    try {
      final response = await http.get(
        Uri.parse('https://emergingideas.ae/test_apis/read.php?email=$email'),
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as List;
        final data = jsonData.map((json) => GetModel.fromJson(json)).toList();
        return data;
      } else {
        throw Exception('Error fetching data: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
