import 'recipe.dart';
import 'recipe.api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:io';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:image_size_getter/file_input.dart';

class ClickedRecipe extends StatefulWidget {
  Recipe recipe;
  ClickedRecipe({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  _ClickedRecipeState createState() => _ClickedRecipeState();
}

class _ClickedRecipeState extends State<ClickedRecipe> {
  bool isLoading = true;

  @override
  void initState() {
    // print(widget.recipe);
    getRecipe();
    super.initState();
  }

  Future<void> getRecipe() async {
    setState(() {
      //catch no servings from Api
      if (widget.recipe.js['details']['numberOfServings'] == null) {
        widget.recipe.numServings = 'N/A';
      } else {
        widget.recipe.numServings =
            widget.recipe.js['details']['numberOfServings'].toString();
      }

      //catch no calories from Api
      if (widget.recipe.js['nutrition']['nutritionEstimates'].length == 0) {
        widget.recipe.cals = 'N/A';
      } else {
        widget.recipe.cals = widget
            .recipe.js['nutrition']['nutritionEstimates'][0]['value']
            .toString();
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Stack(
                  children: [
                    Center(
                        child: Column(
                      children: [
                        Container(
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image:
                                        NetworkImage(widget.recipe.images)))),
                        Text(widget.recipe.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 35)),
                        const Divider(
                            height: 40,
                            thickness: 2,
                            indent: 20,
                            endIndent: 20,
                            color: Colors.grey),
                        // const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.access_time_filled_rounded,
                                    color: Colors.white),
                                const SizedBox(width: 10),
                                Text(widget.recipe.totalTime,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18))
                              ],
                            ),
                            const SizedBox(width: 50),
                            Row(
                              children: [
                                const Icon(Icons.face, color: Colors.white),
                                const SizedBox(width: 10),
                                Text('${widget.recipe.numServings}  serving(s)',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18))
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.local_fire_department_rounded,
                                color: Colors.white),
                            const SizedBox(width: 10),
                            Text('${widget.recipe.cals}  calories',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18))
                          ],
                        ),
                        const SizedBox(height: 25),
                        Container(
                            padding: const EdgeInsets.only(right: 240),
                            child: const Text('Description',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ))),
                        const SizedBox(height: 10),
                        Container(
                            padding: const EdgeInsets.only(left: 15, right: 10),
                            child: Text(widget.recipe.description,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20))),
                        const SizedBox(height: 25),
                        Container(
                            padding: const EdgeInsets.only(right: 240),
                            child: const Text('Ingredients',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ))),
                        const SizedBox(height: 10),
                        Container(
                            padding: const EdgeInsets.only(left: 15, right: 10),
                            child: Text(widget.recipe.ingredients.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20))),
                        const SizedBox(height: 25),
                        Container(
                            padding: const EdgeInsets.only(right: 260),
                            child: const Text('Directions',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ))),
                        const SizedBox(height: 10),
                        Container(
                            padding: const EdgeInsets.only(left: 15, right: 10),
                            child: Text(widget.recipe.directions.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20))),
                        const SizedBox(height: 100),
                      ],
                    )),
                    IconButton(
                        color: Colors.black,
                        iconSize: 40,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back)),
                  ],
                ),
              ));
  }
}
