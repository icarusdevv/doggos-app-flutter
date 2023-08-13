import 'package:doggos_app_flutter/breed/view/breed_images_screen.dart';
import 'package:doggos_app_flutter/breed/viewmodel/breed_view_model.dart';
import 'package:doggos_app_flutter/home/viewmodel/home_view_model.dart';
import 'core/network/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home/view/home_screen.dart';

void main() {
  final doggosApiService = ApiService("https://dog.ceo/api");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel(doggosApiService)),
        ChangeNotifierProvider(create: (_) => BreedViewModel(doggosApiService)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/breeds': (context) => const BreedImagesScreen(),
      },
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Doggos')),
        body: const HomeScreen(),
      ),
    );
  }
}
