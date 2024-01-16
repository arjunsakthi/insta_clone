import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DummyTest extends StatefulWidget {
  const DummyTest({super.key});

  @override
  State<DummyTest> createState() => _DummyTestState();
}

class _DummyTestState extends State<DummyTest> {
  @override
  void dispose() {
    checkCachePath();
    super.dispose();
  }

  final double = 1;
  Future<bool> checkCachePath() async {
    try {
      final temp = await getTemporaryDirectory();
      final appDoc = await getApplicationDocumentsDirectory();
      final appSup = await getApplicationSupportDirectory();
      final down = await getDownloadsDirectory();
      final externalcache = await getExternalCacheDirectories();
      final externalstorages = await getExternalStorageDirectories();
      final externalStorage = await getExternalStorageDirectory();
      // final library = await getLibraryDirectory();
      print(temp.path);
      print(appDoc.path);
      print(appSup.path);
      print(down!.path);
      print(externalcache);
      print(externalstorages);
      print(externalStorage!.path);
      // print(library.path);
    } catch (e) {
      print('This is the Error : ' + e.toString());
    }
    return true;
  }

  String textWidget = "Abhi Tak Kuch Nahi !";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: checkCachePath,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Checking how to free cache memory"),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Center(
                child: Text("hello this is sakthivel"),
              ),
            ),
            TextButton(
              onPressed: checkCachePath,
              child: Text("Execute"),
            ),
          ],
        ),
      ),
    );
  }
}
