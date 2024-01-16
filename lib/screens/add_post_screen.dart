import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/model/user.dart' as model;
import 'package:insta_clone/provider/user_provider.dart';
import 'package:insta_clone/resource/firestore.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController _descriptionController = TextEditingController();
  Uint8List? _file;
  bool posting = false;

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  void postImage(String uuid, String profImage, String username) async {
    try {
      setState(() {
        posting = true;
      });
      String res = await Firestore().uploadPost(
          _descriptionController.text, uuid, _file!, username, profImage);
      setState(() {
        posting = false;
      });
      clearImage();
      if (res == '') {
        showSnackBar(res, context);
      } else {
        showSnackBar(res, context);
      }
    } catch (err) {
      print('error');
      showSnackBar(err.toString(), context);
    }
  }

  _selectImage() async {
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              title: const Text('Create A Post'),
              children: [
                SimpleDialogOption(
                  padding: const EdgeInsets.all(20),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.photo,
                        size: 26,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('From Gallery'),
                    ],
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Uint8List file = await pickImage(ImageSource.gallery);
                    setState(() {
                      _file = file;
                    });
                  },
                ),
                SimpleDialogOption(
                  padding: const EdgeInsets.all(20),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.camera,
                        size: 26,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('From Camera'),
                    ],
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Uint8List file = await pickImage(ImageSource.camera);
                    setState(() {
                      _file = file;
                    });
                  },
                ),
                SimpleDialogOption(
                  padding: const EdgeInsets.all(20),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.cancel_presentation,
                        color: Colors.red,
                        size: 26,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Cancel'),
                    ],
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Uint8List file = await pickImage(ImageSource.gallery);
                    setState(() {
                      _file = file;
                    });
                  },
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final model.user user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Center(
            child: IconButton(
              icon: const Icon(Icons.upload),
              onPressed: () => _selectImage(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  clearImage();
                },
              ),
              title: const Text('Post To'),
              actions: [
                TextButton(
                  onPressed: () {
                    if (_descriptionController.text.trim() != '') {
                      postImage(
                        user.uuid,
                        user.photoUrl,
                        user.username,
                      );
                    }
                  },
                  child: Text(
                    'Post',
                    style: TextStyle(
                        color: posting ? primaryColor : Colors.blueAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  posting
                      ? const LinearProgressIndicator(
                          color: primaryColor,
                        )
                      : const Padding(padding: EdgeInsets.only(top: 0)),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        clipBehavior: Clip.hardEdge,
                        child: FadeInImage(
                          placeholder: MemoryImage(
                              _file!), //MemoryImage(kTransparentImage),
                          image: NetworkImage(user.photoUrl),
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                              hintText: 'Write some Caption Here !!',
                              border: InputBorder.none),
                          maxLines: 8,
                        ),
                      ),
                      SizedBox(
                          height: 45,
                          width: 45,
                          child: AspectRatio(
                            aspectRatio: 487 / 451,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: MemoryImage(_file!),
                                  fit: BoxFit.fill,
                                  alignment: FractionalOffset.topCenter,
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                  const Divider(),
                  const Flexible(
                    flex: 2,
                    child: Text('hi'),
                  ),
                ]),
          );
  }
}
