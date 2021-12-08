import 'package:final_proj/recipe.api.dart';
import 'package:final_proj/starter_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'recipe.dart';
import 'search_result.dart';
import 'clicked_recipe.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.grey,
          fontFamily: 'ShipporiAntiqueB1',
          scaffoldBackgroundColor: Colors.blueGrey.shade400),
      home: const StarterPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Recipe> sampleRecipes = [];
  final myController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  Future<List<Recipe>> getSampleRecipes() async {
    sampleRecipes = await RecipeApi.getSampleRecipe();

    return sampleRecipes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: Text('Final Project'),
      // ),
      body: FutureBuilder(
          future: getSampleRecipes(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // print(sampleRecipes);
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  Container(
                      padding: const EdgeInsets.only(right: 275),
                      child: const Text("Hi there,",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold))),
                  const SizedBox(height: 10),
                  Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: const Text("What do you want to cook today?",
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Container(
                        width: 370.0,
                        child: TextFormField(
                            validator: (value) {
                              if (value != null && value.length > 2) {
                                return null; //Search will work as expected
                              } else if (value != null && value.length <= 2) {
                                return "Try searching again!";
                              } else {
                                return "Please enter a food item!";
                              }
                            },
                            controller: myController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                prefixIcon: IconButton(
                                    onPressed: () {
                                      if (!_formKey.currentState!.validate()) {
                                        return;
                                      }
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SearchResult(
                                                  foodDish: myController.text,
                                                )),
                                      );
                                    },
                                    icon: const Icon(Icons.search)),
                                filled: true,
                                fillColor: Colors.grey.shade300,
                                labelText: "Search recipes",
                                labelStyle: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey.shade500)))),
                  ),
                  const SizedBox(height: 10),
                  Container(
                      // padding: EdgeInsets.only(right: 210),
                      child: const Text('Sample Recipes',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18))),
                  const SizedBox(height: 15),
                  SizedBox(
                      height: 240,
                      child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                          padding: const EdgeInsets.only(right: 10),
                          scrollDirection: Axis.horizontal,
                          itemCount: sampleRecipes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ClickedRecipe(
                                              recipe: sampleRecipes[index],
                                            )),
                                  );
                                },
                                child: Container(
                                  child: Center(
                                      child: Text(sampleRecipes[index].name,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20))),
                                  height: 200,
                                  width: 160,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      color: Colors.black,
                                      image: DecorationImage(
                                        colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.6),
                                            BlendMode.dstATop),
                                        image: NetworkImage(
                                          sampleRecipes[index].images,
                                        ),
                                        fit: BoxFit.cover,
                                      )),
                                  // child: Column(
                                  //   children: [Text('Lasagna')],
                                  // )
                                ));
                          }))
                ],
              ),
            );
          }),
      // bottomNavigationBar: BottomAppBar(
      //     color: Colors.transparent,
      //     child: Row(
      //       children: [
      //         const SizedBox(
      //           width: 10,
      //         ),
      //         IconButton(
      //           iconSize: 30,
      //           color: Colors.white,
      //           icon: const Icon(Icons.home),
      //           onPressed: () {},
      //         ),
      //         const SizedBox(
      //           width: 35,
      //         ),
      //         IconButton(
      //           iconSize: 30,
      //           color: Colors.white,
      //           icon: const Icon(Icons.auto_stories),
      //           onPressed: () {},
      //         ),
      //       ],
      //     )),
    );
  }
}
