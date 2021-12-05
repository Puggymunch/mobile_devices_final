import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'addrecipe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipeApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StreamBuilderWidget(title: 'Sample Recipe Home Page'),
      routes: {
        '/addrecipe': (context) => const AddRecipe(),
      },
    );
  }
}

class StreamBuilderWidget extends StatefulWidget {
  const StreamBuilderWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StreamBuilderWidget> createState() => _StreamBuilderWidgetState();
}

class _StreamBuilderWidgetState extends State<StreamBuilderWidget> {
  final recipes = FirebaseFirestore.instance.collection("recipes");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/addrecipe');
          },
          tooltip: 'Create your own!',
          child: const Icon(Icons.add),
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
                      title: Text(docData["title"]),
                      subtitle: Text(docData["ingredients"]),
                    );
                  }); // This trailing comma makes auto-formatting nicer for build methods.
            }));
  }
}
