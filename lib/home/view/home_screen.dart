import 'package:doggos_app_flutter/home/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future dogsBreeds;
  late final viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<HomeViewModel>(context, listen: false);
    dogsBreeds = viewModel.fetchDogsBreeds();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dogsBreeds,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Text('Error on fetch dogs breeds!');
        } else {
          return ListView.builder(
            itemCount: viewModel.breeds.length,
            itemBuilder: (context, index) {
              final key = viewModel.breeds.keys.elementAt(index);
              return ListTile(
                title: Text(key),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/breeds',
                    arguments: key,
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
