import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import '../../../data/favourite.dart';

class FavouriteViewModel extends ChangeNotifier {
  final Box<Favourite> box;

  FavouriteViewModel(this.box);

  void saveFavourite(Favourite favourite) async {
    var existingKey = box.keys.firstWhere(
        (key) => box.get(key)?.title == favourite.title,
        orElse: () => null);

    if (existingKey != null) {
      await box.delete(existingKey);
    } else {
      await box.add(favourite);
    }
    notifyListeners();
  }

  bool verifyIfExist(String key) {
    var existingKey = box.keys
        .firstWhere((k) => box.get(k)?.title == key, orElse: () => null);
    return existingKey != null;
  }
}
