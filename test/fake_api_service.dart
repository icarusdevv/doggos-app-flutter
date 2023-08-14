import 'package:doggos_app_flutter/core/network/api_service.dart';

class FakeApiService extends ApiService {
  late Future<Map<String, dynamic>> Function() fetchDogsBreedsFunction;
  late Future<List<dynamic>> Function(String) fetchAllImagesFromBreedFunc;

  Map<String, dynamic>? breedsToReturn;
  List<dynamic>? breedsImagesToReturn;
  Exception? errorToThrow;

  FakeApiService(super.url);

  @override
  Future<Map<String, dynamic>> fetchDogsBreeds() async {
    if (errorToThrow != null) {
      throw errorToThrow!;
    }
    return breedsToReturn ?? {};
  }

  @override
  Future<List<dynamic>> fetchAllImagesFromBreed(var dogName) {
    return fetchAllImagesFromBreedFunc(dogName);
  }
}
