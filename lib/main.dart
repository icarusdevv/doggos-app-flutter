import 'package:doggos_app_flutter/home/viewmodel/home_view_model.dart';
import '../../api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home/view/home_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(ApiService('https://dog.ceo/api/breeds/list/all')),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('Doggos App')),
          body: const ItemList(),
        ),
      ),
    );
  }
}

