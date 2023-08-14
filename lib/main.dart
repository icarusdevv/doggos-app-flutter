import 'package:doggos_app_flutter/features/breed/view/breed_images_screen.dart';
import 'package:doggos_app_flutter/features/breed/viewmodel/breed_view_model.dart';
import 'package:doggos_app_flutter/features/home/viewmodel/home_view_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/network/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/favourite.dart';
import 'features/favorites/view/favorites_screen.dart';
import 'features/favorites/viewmodel/favourite_view_model.dart';
import 'features/home/view/home_screen.dart';

void main() async {
  //Hive Setup
  await Hive.initFlutter();
  Hive.registerAdapter(FavouriteAdapter());
  final box = await Hive.openBox<Favourite>('favourites');
  final favouritesModel = FavouriteViewModel(box);

  final doggosApiService = ApiService("https://dog.ceo/api");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel(doggosApiService)),
        ChangeNotifierProvider(create: (_) => BreedViewModel(doggosApiService)),
        ChangeNotifierProvider(create: (_) => favouritesModel),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    FavouritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/breeds': (context) => const BreedImagesScreen(),
        '/favourites': (context) => const FavouritesScreen(),
      },
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Doggos'),
          centerTitle: true,
        ),
        body: Center(
          child: _pages.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favourites',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
