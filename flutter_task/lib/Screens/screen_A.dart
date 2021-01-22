import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/Screens/add_article.dart';

class ScreenA extends StatefulWidget {
  @override
  _ScreenAState createState() => _ScreenAState();
}

class _ScreenAState extends State<ScreenA> {
  final ref = FirebaseFirestore.instance.collection('Articles');
  final items = List<String>.generate(20, (i) => "Item ${i + 1}");

  String imageURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Articles',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.create),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddArticle()),
          );
        },
      ),
      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return ListView.builder(
              itemCount: snapshot.hasData ? snapshot.data.docs.length : 0,
              itemBuilder: (context, index) {
                final item = items[index];
                return Padding(
                  padding: EdgeInsets.all(5),
                  child: Dismissible(
                    key: Key(item),

                    onDismissed: (direction) {
                      // it will Help remove the item data document.
                      setState(() {
                        items.removeAt(index);
                      });

                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("$item dismissed")));
                    },
                    // Shows a red background
                    background: Container(color: Colors.red),

                    child: ListTile(
                      leading: Card(
                        child: CachedNetworkImage(
                          imageUrl: snapshot.data.docs[index]['imageURL'] ??
                              CircularProgressIndicator(),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(snapshot.data.docs[index]['title']),
                      subtitle: Text(snapshot.data.docs[index]['description']),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
