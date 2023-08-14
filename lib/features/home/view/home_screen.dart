import 'package:doggos_app_flutter/data/favourite.dart';
import 'package:doggos_app_flutter/features/home/viewmodel/home_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../favorites/viewmodel/favourite_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final dogsBreeds;
  late final viewModel;
  var box;
  late ValueListenable<Box<Favourite>> boxListenable;

  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<HomeViewModel>(context, listen: false);
    dogsBreeds = viewModel.fetchDogsBreeds();
    openBox();
  }

  openBox() async {
    box = await Hive.openBox<Favourite>('favourites');
    setState(() {});
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
          return const Text('Error on fetch data!');
        } else {
          return Consumer<FavouriteViewModel>(
            builder: (context, favouritesModel, _) => ListView.separated(
              itemCount: viewModel.breeds.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
              itemBuilder: (context, index) {
                final key = viewModel.breeds.keys.elementAt(index);
                return ListTile(
                  title: Text(key),
                  trailing: InkWell(
                    onTap: () {
                      favouritesModel.saveFavourite(Favourite(key, []));
                    },
                    child: Icon(
                      favouritesModel.verifyIfExist(key)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: favouritesModel.verifyIfExist(key)
                          ? Colors.red
                          : null,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/breeds',
                      arguments: key,
                    );
                  },
                );
              },
            ),
          );
        }
      },
    );
  }
}
