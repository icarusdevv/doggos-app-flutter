import 'package:doggos_app_flutter/breed/viewmodel/breed_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BreedImagesScreen extends StatefulWidget {
  const BreedImagesScreen({super.key});

  @override
  State<BreedImagesScreen> createState() => _BreedImagesScreenState();
}

class _BreedImagesScreenState extends State<BreedImagesScreen> {
  late Future<List<dynamic>> dogsBreedsImages;
  late final viewModel;
  late final dynamic item;
  String displayDogBreedName = "";

  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<BreedViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    item = ModalRoute.of(context)!.settings.arguments;
    displayDogBreedName = item is String ? item : 'Invalid dog breed name';
    dogsBreedsImages = viewModel.fetchAllImagesFromBreed(item);

    return Scaffold(
        appBar: AppBar(
          title: Text(displayDogBreedName),
        ),
        body: FutureBuilder(
          future: dogsBreedsImages,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Text('Error on fetch dogs breeds!');
            } else {
              return GridView.count(
                crossAxisCount: 2,
                children: List.generate(viewModel.images.length, (index) {
                  return Center(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        viewModel.images[index],
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          }
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
              );
            }
          },
        ));
  }
}
