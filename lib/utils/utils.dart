import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/utils/colors.dart';

pickImage(ImageSource imageSource) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: imageSource);
  if (_file != null) {
    return await _file!.readAsBytes();
    // we can use File(_file) but for web need to use the above way .
  }
  print('No image Selected');
}

showSnackBar(String Content, BuildContext context) {
  // SnackBar(
  //   content: Text(Content),
  // );
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      backgroundColor: primaryColor,
      dismissDirection: DismissDirection.startToEnd,
      closeIconColor: Colors.black,
      content: Text(Content),
    ),
  );
}
