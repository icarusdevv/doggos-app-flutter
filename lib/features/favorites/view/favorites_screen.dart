import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../../data/favourite.dart';
import '../../breed/viewmodel/breed_view_model.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  late final viewModel;
  List<Favourite>? favouritesList;
  Map<String, Future<List<dynamic>>> dogsBreedsImagesFutures = {};

  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<BreedViewModel>(context, listen: false);
    _loadData();
  }

  _loadData() async {
    var box = await Hive.openBox<Favourite>('favourites');
    favouritesList = box.values.toList();

    for (var favourite in favouritesList!) {
      dogsBreedsImagesFutures[favourite.title] =
          viewModel.fetchAllImagesFromBreed(favourite.title);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (favouritesList == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      body: ListView.builder(
        key: const PageStorageKey('favourites_list'),
        itemCount: favouritesList!.length,
        itemBuilder: (context, index) {
          String title = favouritesList![index].title;
          return FutureBuilder<List<dynamic>>(
            future: dogsBreedsImagesFutures[title],
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Center(child: CircularProgressIndicator()),
                  ],
                );
              } else if (snapshot.hasError || !snapshot.hasData) {
                return const Center(child: Text('Error fetching images'));
              } else {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      children: List.generate(
                        snapshot.data!.take(5).length,
                        (index) {
                          return Center(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                snapshot.data![index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }
}
