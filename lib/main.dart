import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'addrecipe.dart';
import 'map.dart';
import 'grocery_stores.dart';

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
        '/display_stores': (context) => GroceryStores(),
        '/display_map': (context) => Map()
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
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/addrecipe');
          },
          tooltip: 'Create your own!',
          child: const Icon(Icons.add),
        ),
        FloatingActionButton(
          onPressed: () {
            setState(() {
              Navigator.pushNamed(
                context,
                '/display_stores',
              );
            });
          },
          tooltip: 'Look for grocery stores near you.',
          child: const Icon(Icons.location_on),
        ),
      ]),
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
          }),
    );
  }
}
