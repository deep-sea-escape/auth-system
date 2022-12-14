import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import './user_image.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage)? onPicked;
  const UserImagePicker({this.onPicked, Key? key}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;
  ImageSource? _imageSource;

  void _pickImage() async {
    await showDialog(
      context: context,
      builder: (BuildContext ctx) {
        _imageSource = null;
        return SimpleDialog(
          children: [
            TextButton(
              child: const Text('카메라로 촬영하기'),
              onPressed: () {
                _imageSource = ImageSource.camera;
                Navigator.of(ctx).pop();
              },
            ),
            TextButton(
              child: const Text('앨범에서 가져오기'),
              onPressed: () {
                _imageSource = ImageSource.gallery;
                Navigator.of(ctx).pop();
              },
            ),
          ],
        );
      },
    );

    if (_imageSource != null) {
      final imagePicker = ImagePicker();
      final pickedImageFile = await imagePicker.pickImage(
        source: _imageSource!,
        imageQuality: 50,
        maxWidth: 150,
      ); // imageQuality는 0 ~ 100 사이의 값 주는 것!

      setState(() {
        _pickedImage =
            pickedImageFile != null ? File(pickedImageFile.path) : null;
      });

      if (pickedImageFile != null && widget.onPicked != null) {
        widget.onPicked!(File(pickedImageFile.path));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const double size = 30;
    return GestureDetector(
      onTap: _pickImage,
      child: Stack(
        children: [
          UserImage(
              radius: size,
              image: _pickedImage != null ? FileImage(_pickedImage!) : null),
          const Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              radius: size / 3,
              backgroundColor: Colors.white,
              child: Icon(Icons.edit, size: size / 2.5, color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
