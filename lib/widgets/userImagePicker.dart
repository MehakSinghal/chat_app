import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File image) imagePickFn;

  UserImagePicker(this.imagePickFn);

  @override
  _USerImagePickerState createState() => _USerImagePickerState();
}

class _USerImagePickerState extends State<UserImagePicker> {
  File _image;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 150,
      imageQuality: 50,
    );
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _image = pickedImageFile;
    });
    widget.imagePickFn(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundImage: _image != null ? FileImage(_image) : null,
        ),
        FlatButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.camera_alt),
          label: Text(
            'Take a picture',
          ),
          textColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
