import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart'; // use 0.4.0 version
import 'package:insta_clone/resource/firestore.dart';
import 'package:insta_clone/screens/profile_screen.dart';
import 'package:insta_clone/utils/colors.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller = TextEditingController(text: '');
  bool _show = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Search for a User'),
            onFieldSubmitted: (String _) {
              // there will be a done option in keyboard for submitting.
              print(_);
              setState(() {
                _show = true;
              });
            }),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('posts')
            .where('userName', isGreaterThanOrEqualTo: _controller.text)
            .get(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapShot) {
          if (!snapShot.hasData)
            return Center(
              child: Container(
                height: MediaQuery.sizeOf(context).width * 0.6,
                width: MediaQuery.sizeOf(context).width * 0.6,
                child: CircularProgressIndicator(color: Colors.blue),
              ),
            );
          print(snapShot.data!.docs.length);
          return _show
              ? ListView.builder(
                  itemCount: snapShot.data!.docs.length,
                  itemBuilder: (context, indx) => ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                          uid: (snapShot.data as dynamic).docs[indx]['uid'],
                        ),
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          (snapShot.data as dynamic).docs[indx]['postUrl']),
                    ),
                    title:
                        Text((snapShot.data as dynamic).docs[indx]['userName']),
                  ),
                )
              : FutureBuilder(
                  future: FirebaseFirestore.instance.collection('posts').get(),
                  builder: (context, snapShot) {
                    if (!snapShot.hasData)
                      return Center(
                        child: Container(
                          height: MediaQuery.sizeOf(context).width * 0.6,
                          width: MediaQuery.sizeOf(context).width * 0.6,
                          child: CircularProgressIndicator(color: Colors.amber),
                        ),
                      );

                    return StaggeredGridView.countBuilder(
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      crossAxisCount: 3,
                      staggeredTileBuilder: (idx) => StaggeredTile.count(
                        idx % 7 == 0 ? 2 : 1,
                        idx % 7 == 0 ? 2 : 1,
                      ),
                      itemCount: (snapShot.data! as dynamic).docs.length,
                      itemBuilder: (context, index) => FadeInImage(
                        placeholder: AssetImage(
                            'assets/placeholder.jpg'), //MemoryImage(kTransparentImage),
                        image: NetworkImage(
                          (snapShot.data! as dynamic).docs[index]['postUrl'],
                        ),
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
