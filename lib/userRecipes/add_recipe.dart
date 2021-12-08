import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'firebase_api.dart';
import 'dart:io';
import 'package:path/path.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({Key? key}) : super(key: key);

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final recipes = FirebaseFirestore.instance.collection("recipes");
  var titleController = TextEditingController();
  var ingredientsController = TextEditingController();
  var instructionsController = TextEditingController();
  var preptimeController = TextEditingController();
  var cooktimeController = TextEditingController();
  var totaltimeController = TextEditingController();
  var servingsController = TextEditingController();
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      print("path: " + image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future uploadImage() async {
    if (image == null) return;

    final fileName = basename(image!.path);
    final destination = 'images/$fileName';

    FirebaseApi.uploadFile(destination, image!);
  }

  @override
  Widget build(BuildContext context) {
    final fileName = image != null ? basename(image!.path) : "No Image Data";

    return Scaffold(
        appBar: AppBar(
          title: Text('Create a Recipe!',
              style: TextStyle(fontSize: 20, color: Colors.black)),
          backgroundColor: Colors.amber,
        ),
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 25,
                ),
                Text("Title:", style: TextStyle(fontSize: 15)),
                const SizedBox(
                  width: 50,
                ),
                Container(
                    width: 250,
                    child: TextFormField(
                        minLines: 1,
                        maxLines: 20,
                        controller: titleController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                        ))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 6,
                ),
                Text("Ingredients:", style: TextStyle(fontSize: 15)),
                const SizedBox(
                  width: 50,
                ),
                Container(
                    width: 250,
                    child: TextField(
                        minLines: 1,
                        maxLines: 20,
                        controller: ingredientsController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                        ))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Instructions:", style: TextStyle(fontSize: 15)),
                const SizedBox(
                  width: 50,
                ),
                Container(
                    width: 250,
                    child: TextField(
                        minLines: 1,
                        maxLines: 20,
                        controller: instructionsController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                        ))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Text("Prep Time:", style: TextStyle(fontSize: 15)),
                const SizedBox(
                  width: 50,
                ),
                Container(
                    width: 250,
                    child: TextField(
                        controller: preptimeController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                        ))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 7,
                ),
                Text("Cook Time:", style: TextStyle(fontSize: 15)),
                const SizedBox(
                  width: 50,
                ),
                Container(
                    width: 250,
                    child: TextField(
                        controller: cooktimeController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                        ))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 8,
                ),
                Text("Total Time:", style: TextStyle(fontSize: 15)),
                const SizedBox(
                  width: 50,
                ),
                Container(
                    width: 250,
                    child: TextField(
                        controller: totaltimeController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                        ))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text("Servings:", style: TextStyle(fontSize: 15)),
                const SizedBox(
                  width: 50,
                ),
                Container(
                    width: 250,
                    child: TextField(
                        controller: servingsController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                        ))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text("Photo(s):", style: TextStyle(fontSize: 15)),
                const SizedBox(
                  width: 50,
                ),
                buildButton(
                  title: 'Photo from Gallery',
                  icon: Icons.image_outlined,
                  onClicked: () {
                    pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                  width: 139,
                ),
                buildButton(
                  title: 'Take Photo',
                  icon: Icons.camera_alt_outlined,
                  onClicked: () {
                    pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(fileName),
              ],
            )
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 35.0),
          child: FloatingActionButton(
            child: Icon(Icons.save),
            onPressed: () {
              addRecipe();
              uploadImage();
              Navigator.pop(context, true);
            },
            backgroundColor: Colors.amber,
          ),
        ));
  }

  Widget buildButton({
    required String title,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton(
        child: Row(
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 16),
            Text(title),
          ],
        ),
        onPressed: onClicked,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.amber),
          textStyle: MaterialStateProperty.all(TextStyle(fontSize: 15)),
        ),
      );

  Future<void> addRecipe() {
    return recipes
        .add({
          'title': titleController.text,
          'ingredients': ingredientsController.text,
          'instructions': instructionsController.text,
          'preptime': preptimeController.text,
          'cooktime': cooktimeController.text,
          'totaltime': totaltimeController.text,
          'servings': servingsController.text
        })
        .then((value) => print("Recipe Added"))
        .catchError((error) => print("Faile to add recipe: $error"));
  }
}
