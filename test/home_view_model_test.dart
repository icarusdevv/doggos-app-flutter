import 'package:doggos_app_flutter/features/home/viewmodel/home_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_api_service.dart';

void main() {
  group('exec HomeViewModel', () {
    late FakeApiService apiService;
    late HomeViewModel homeViewModel;

    setUp(() {
      apiService = FakeApiService('');
      homeViewModel = HomeViewModel(apiService);
    });

    test('when fetchDogsBreeds throws success', () async {
      final breeds = {
        'golden': 'Golden',
      };
      apiService.breedsToReturn = breeds;

      await homeViewModel.fetchDogsBreeds();

      expect(homeViewModel.breeds, breeds);
    });

    test('when fetchDogsBreeds throws failure', () async {
      apiService.errorToThrow = Exception('Failed to fetch breeds');

      await homeViewModel.fetchDogsBreeds();

      expect(homeViewModel.breeds, isEmpty);
    });
  });
}
