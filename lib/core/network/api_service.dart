import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ApiService {
  final String url;

  ApiService(this.url);

  Future<Map<String, dynamic>> fetchDogsBreeds() async {
    final response = await http.get(Uri.parse('$url/breeds/list/all'));

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var parsedResponse = jsonResponse as Map<String, dynamic>;
      return parsedResponse['message'];
    } else {
      throw Exception('Failed to load Dog Breeds');
    }
  }

  Future<List<dynamic>> fetchAllImagesFromBreed(var dogName) async {
    final response = await http.get(Uri.parse('$url/breed/$dogName/images'));

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var parsedResponse = jsonResponse as Map<String, dynamic>;
      return parsedResponse['message'] as List<dynamic>;
    } else {
      throw Exception('Failed to load Dog Images');
    }
  }
}
