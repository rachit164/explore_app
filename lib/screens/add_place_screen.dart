import 'dart:io';

import 'package:explore_app/providers/great_places.dart';
import 'package:explore_app/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/loaction_input.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);
  static const routeName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  late File _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("No image selected"),
            content: const Text("Select an Image"),
            actions: [
              TextButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                    const SizedBox(
                      height: 10,
                    ),
                    const LocationInput(),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context)
                    .colorScheme
                    .secondary, //background color of button
                elevation: 0,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            onPressed: () {
              _savePlace();
            },
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
            label: const Text(
              'Add Place',
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
