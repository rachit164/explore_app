import 'package:explore_app/providers/great_places.dart';
import 'package:explore_app/screens/add_place_screen.dart';
import 'package:explore_app/screens/places_list_screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
              .copyWith(secondary: Colors.amber),
        ),
        home: const PlacesList(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => const AddPlaceScreen(),
        },
      ),
    );
  }
}
