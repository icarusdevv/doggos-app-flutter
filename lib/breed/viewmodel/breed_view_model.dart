import 'package:flutter/material.dart';
import '../../core/network/api_service.dart';

class BreedViewModel extends ChangeNotifier {
  List<dynamic> images = [];

  final ApiService apiService;

  BreedViewModel(this.apiService);

  Future<List<dynamic>> fetchAllImagesFromBreed(var dogName) async {
    try {
      return images = await apiService.fetchAllImagesFromBreed(dogName);
    } catch (e) {
      return [];
    }
  }
}
