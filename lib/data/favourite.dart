import 'package:hive/hive.dart';
part 'favourite.g.dart';

@HiveType(typeId: 0)
class Favourite {
  @HiveField(0)
  String title;

  @HiveField(1)
  List<String> images;

  Favourite(this.title, this.images);
}
