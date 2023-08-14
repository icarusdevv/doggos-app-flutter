import 'package:doggos_app_flutter/features/breed/viewmodel/breed_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_api_service.dart';

void main() {
  group('exec BreedViewModel', () {
    late FakeApiService fakeApiService;
    late BreedViewModel breedViewModel;

    setUp(() {
      fakeApiService = FakeApiService('');
      breedViewModel = BreedViewModel(fakeApiService);
    });

    test('when fetchAllImagesFromBreed throws success', () async {
      final images = ['doggo1.png', 'doggo2.png'];
      fakeApiService.fetchAllImagesFromBreedFunc = (dogName) async => images;

      final result = await breedViewModel.fetchAllImagesFromBreed('golden');

      expect(result, images);
      expect(breedViewModel.images, images);
    });

    test('when fetchAllImagesFromBreed throws failure', () async {
      fakeApiService.fetchAllImagesFromBreedFunc =
          (dogName) async => throw Exception('Failed to load Dog Images');

      final result = await breedViewModel.fetchAllImagesFromBreed('golden');

      expect(result, []);
      expect(breedViewModel.images, []);
    });
  });
}
