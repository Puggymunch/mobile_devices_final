import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras = [];

class AddRecipe extends StatefulWidget {
  const AddRecipe({Key? key}) : super(key: key);

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final recipes = FirebaseFirestore.instance.collection("recipes");
  var titleController = TextEditingController();
  var ingredientsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a Recipe!', style: TextStyle(fontSize: 12)),
        backgroundColor: Colors.amber,
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Title:", style: TextStyle(fontSize: 12)),
              SizedBox(
                width: 50,
              ),
              Container(
                  width: 250,
                  child: TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                      ))),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Add Ingredients:", style: TextStyle(fontSize: 12)),
              SizedBox(
                width: 50,
              ),
              Container(
                  width: 250,
                  child: TextField(
                      controller: ingredientsController,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                      ))),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () {
            //addStudent();
            Navigator.pop(context, true);
          }),
    );
  }
}
