import 'package:final_proj/clicked_recipe.dart';

import 'recipe.dart';
import 'recipe.api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class SearchResult extends StatefulWidget {
  var foodDish;
  SearchResult({Key? key, required this.foodDish}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  List<Recipe> searchRecipes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<List<Recipe>> getRecipes() async {
    searchRecipes = await RecipeApi.getSearchRecipe(widget.foodDish);

    return searchRecipes;
  }

//we have to index searchRecipes based on user click

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getRecipes(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return Stack(
          children: [
            ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 5,
                  );
                },
                itemCount: searchRecipes.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ClickedRecipe(recipe: searchRecipes[index])),
                      );
                      // print(searchRecipes[index]);
                    },
                    title: Text(
                      searchRecipes[index].name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    // subtitle: Text("bob"),
                    leading: CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          NetworkImage(searchRecipes[index].images),
                    ),
                  );
                }),
            IconButton(
                color: Colors.black,
                iconSize: 40,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
          ],
        );
      },
    ));
  }
}
