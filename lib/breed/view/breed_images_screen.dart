import 'package:flutter/material.dart';

class BreedImagesScreen extends StatefulWidget {
  const BreedImagesScreen({super.key});


  @override
  State<BreedImagesScreen> createState() => _BreedImagesScreenState();
}

class _BreedImagesScreenState extends State<BreedImagesScreen> {
  @override
  Widget build(BuildContext context) {
   final dynamic item = ModalRoute.of(context)!.settings.arguments;
   final String displayText = item is String ? item : 'Invalid item';

    return Scaffold(
      appBar: AppBar(
        title: Text(displayText),
      ),
      body: Center(
        child: Text(displayText),
      ),
    );
  }
}