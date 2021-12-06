import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_recipe.dart';

class StreamBuilderWidget extends StatefulWidget {
  const StreamBuilderWidget({Key? key}) : super(key: key);

  @override
  State<StreamBuilderWidget> createState() => _StreamBuilderWidgetState();
}

class _StreamBuilderWidgetState extends State<StreamBuilderWidget> {
  final recipes = FirebaseFirestore.instance.collection("recipes");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddRecipe()),
              );
            },
            tooltip: 'Create your own!',
            child: const Icon(Icons.add),
          ),
        ),
        body: StreamBuilder(
            stream: recipes.snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    var docData = snapshot.data.docs[index].data();
                    return ListTile(
                      title: Text(docData["title"],
                          style: TextStyle(color: Colors.white)),
                      subtitle: Text(docData["ingredients"],
                          style: TextStyle(color: Colors.white)),
                    );
                  }); // This trailing comma makes auto-formatting nicer for build methods.
            }));
  }
}
