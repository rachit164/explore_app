import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  const ImageInput(this.onSelectImage, {Key? key}) : super(key: key);
  final Function onSelectImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  var _storedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    // final imageFile =
    //     await picker.getImage(source: ImageSource.camera, maxHeight: 600);
    XFile? imageFile =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 600);
    setState(() {
      _storedImage = File(imageFile!.path);
    });

    if (imageFile == null) {
      return;
    }
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: _takePicture,
            icon: const Icon(Icons.camera),
            label: Text(
              'Take Picture',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
