import 'package:doggos_app_flutter/home/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemList extends StatefulWidget  {
  const ItemList({super.key});
    @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  late Future itemsFuture;

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<HomeViewModel>(context, listen: false);
    itemsFuture = viewModel.fetchItems();
  }

  @override
  Widget build(BuildContext context) {

    final viewModel = Provider.of<HomeViewModel>(context);

    return FutureBuilder(
      future: itemsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error');
        } else {
          return ListView.builder(
          itemCount: viewModel.breeds.length,
          itemBuilder: (context, index) {
            final key = viewModel.breeds.keys.elementAt(index);
            return ListTile(title: Text(key));
          },
        );
        }
      },
    );
  }
}


