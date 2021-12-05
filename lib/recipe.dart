class Recipe {
  String name;
  String images;
  String ingredients;
  String totalTime;
  String numServings;
  String cals;
  String description;
  String directions;
  dynamic js;

  Recipe(
      {required this.name,
      required this.images,
      required this.ingredients,
      required this.totalTime,
      required this.numServings,
      required this.cals,
      required this.js,
      required this.description,
      required this.directions});

  // factory Recipe.sample(dynamic json) {
  //   return Recipe(
  //       name: json['name'] as String,
  //       images: json['images'][0]['hostedLargeUrl'] as String,
  //       ingredients: "[]",
  //       /////
  //       totalTime: "",
  //       numServings: "",
  //       cals: "",
  //       description: "",
  //       directions: "[]",
  //       js: null);
  // }

  factory Recipe.search(dynamic json) {
    var dir = [];
    String desc;
    String time;
    var j = 1;
    List ingredientList = [];

    //catch no time from api
    if (json['details']['totalTime'] == null ||
        json['details']['totalTime'] == "") {
      time = "N/A";
    } else {
      time = json['details']['totalTime'];
    }

    //catch no ingredients from api & format
    if (json['ingredientLines'].length == 0) {
      ingredientList = ['Find needed ingredients at www.yummly.com'];
    } else {
      json['ingredientLines'].map((data) {
        return ingredientList.add(data['ingredient']);
      }).toList();
    }
    String ingrFormatted = ingredientList.join(', ');

    //catch no directions from api & format
    if (json['preparationSteps'] == null) {
      dir = [
        "Learn how to make the ${json['details']['name']} at www.yummly.com"
      ];
    } else {
      for (var i in json['preparationSteps']) {
        dir.add('${j}. ' + i);
        j = j + 1;
      }
    }
    String dirFormatted = dir.join('\n\n');

    //catch no description from api
    if (json['description'] == null || json['description']['text'] == "") {
      desc =
          "Find more details about the ${json['details']['name']} at www.yummly.com";
    } else {
      desc = json['description']['text'];
    }

    return Recipe(
        name: json['details']['name'] as String,
        images: json['details']['images'][0]['hostedLargeUrl'] as String,
        ingredients: ingrFormatted,
        totalTime: time,
        description: desc,
        numServings: "", //initialized in 'clicked_recipe.dart'
        cals: "", //initialized in 'clicked_recipe.dart'
        directions: dirFormatted,
        js: json); //['content'] in API
  }

  static List<Recipe> sampleRecipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Recipe.search(data);
    }).toList();
  }

//snapshot is a list of "content" from feeds/search
  static List<Recipe> searchRecipesFromSnapshot(List snapshot) {
    // print(snapshot);
    return snapshot.map((data) {
      return Recipe.search(data); //data is the whole "content" list
    }).toList();
  }

  @override
  String toString() {
    return 'Recipe {name: $name, image: $images, ingredients: $ingredients, totalTime: $totalTime}';
  }
}
