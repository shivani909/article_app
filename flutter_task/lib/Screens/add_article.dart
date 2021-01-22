import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddArticle extends StatefulWidget {
  @override
  _AddArticleState createState() => _AddArticleState();
}

class _AddArticleState extends State<AddArticle> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('Articles');

  List controllerList;

  @override
  void initState() {
    super.initState();
    controllerList = [
      ['Title', titleController],
      ['Description', descriptionController],
      ['Image Url', imageUrlController],
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Articles',
            style: TextStyle(color: Colors.black, fontSize: 25)),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(children: [
          for (var titleWithController in controllerList)
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: titleWithController[1],
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey[200])),
                  fillColor: Colors.grey[200],
                  filled: true,
                  hintStyle: TextStyle(fontSize: 17),
                  hintText: '${titleWithController[0]}',
                ),
              ),
            ),
          SizedBox(height: 70),
          FlatButton(
              minWidth: 300.0,
              height: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.green[400],
              onPressed: () {
                ref.add({
                  'title': titleController.text,
                  'description': descriptionController.text,
                  'imageURL': imageUrlController.text,
                }).whenComplete(() => Navigator.pop(context));
              },
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              )),
        ]),
      ),
    );
  }
}
