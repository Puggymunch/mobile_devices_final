import 'dart:convert';
import "recipe.dart";
import 'package:http/http.dart' as http;

class RecipeApi {
  static Future<List<Recipe>> getSearchRecipe(dynamic recipe) async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/search',
        {"start": "0", "maxResult": "18", "q": recipe});

    var response = await http.get(uri, headers: {
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "x-rapidapi-key": "4c916849dbmsh5b89e8a5306a879p10e76bjsn545e083eb59c",
      "useQueryString": "true"
    });

    var data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['feed']) {
      _temp.add(i['content']);
    }

    return Recipe.searchRecipesFromSnapshot(_temp);
  }

  static Future<List<Recipe>> getSampleRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "18", "start": "0", "tag": "list.recipe.popular"});

    var response = await http.get(uri, headers: {
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "x-rapidapi-key": '4c916849dbmsh5b89e8a5306a879p10e76bjsn545e083eb59c',
      "useQueryString": "true"
    });

    var data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['feed']) {
      _temp.add(i['content']);
    }

    return Recipe.sampleRecipesFromSnapshot(_temp);
  }
}
