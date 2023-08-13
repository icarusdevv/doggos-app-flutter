import 'package:flutter/material.dart';
import '../../core/network/api_service.dart';

class HomeViewModel extends ChangeNotifier {
  Map<String, dynamic> breeds = {};

  List<String> images = [];

  final ApiService apiService;

  HomeViewModel(this.apiService);

  Future<void> fetchDogsBreeds() async {
    try {
      breeds = await apiService.fetchDogsBreeds();
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}
