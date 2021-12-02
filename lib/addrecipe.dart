import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

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
  var instructionsController = TextEditingController();
  var preptimeController = TextEditingController();
  var cooktimeController = TextEditingController();
  var totaltimeController = TextEditingController();
  var servingsController = TextEditingController();
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              SizedBox(
                width: 25,
              ),
              Text("Title:", style: TextStyle(fontSize: 15)),
              SizedBox(
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
              SizedBox(
                width: 6,
              ),
              Text("Ingredients:", style: TextStyle(fontSize: 15)),
              SizedBox(
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
              SizedBox(
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
              SizedBox(
                width: 10,
              ),
              Text("Prep Time:", style: TextStyle(fontSize: 15)),
              SizedBox(
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
              SizedBox(
                width: 7,
              ),
              Text("Cook Time:", style: TextStyle(fontSize: 15)),
              SizedBox(
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
              SizedBox(
                width: 8,
              ),
              Text("Total Time:", style: TextStyle(fontSize: 15)),
              SizedBox(
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
              SizedBox(
                width: 20,
              ),
              Text("Servings:", style: TextStyle(fontSize: 15)),
              SizedBox(
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
              SizedBox(
                width: 20,
              ),
              Text("Photo(s):", style: TextStyle(fontSize: 15)),
              SizedBox(
                width: 50,
              ),
              ElevatedButton(
                child: Row(children: [
                  Icon(Icons.camera_alt_outlined, size: 28),
                  Text("Take Photo")
                ]),
                onPressed: () {
                  setState(() {
                    _controller = CameraController(
                        cameras.first, ResolutionPreset.medium);
                    _initializeControllerFuture = _controller.initialize();

                    FutureBuilder<void>(
                        future: _initializeControllerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return CameraPreview(_controller);
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        });
                  });
                },
              ),
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
