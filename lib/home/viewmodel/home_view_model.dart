import 'package:flutter/material.dart';
import '../../api_service.dart';

class HomeViewModel extends ChangeNotifier {
  Map<String, dynamic> breeds = {};

  final ApiService apiService;

  HomeViewModel(this.apiService);

  Future<void> fetchItems() async {
    try {
      breeds = await apiService.fetchDogsBreeds();
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}
