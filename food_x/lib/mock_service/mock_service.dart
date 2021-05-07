import 'dart:convert';
import 'dart:math';

// 1
import 'package:chopper/chopper.dart';

// 2
import 'package:flutter/services.dart' show rootBundle;
import '../network/model_response.dart';
import '../network/recipe_model.dart';

class MockService {
  // 1
  APIRecipeQuery _currentRecipes1;
  APIRecipeQuery _currentRecipes2;

  // 2
  Random nextRecipe = Random();

// 3
  void create() {
    loadRecipes();
  }

  void loadRecipes() async {
    var jsonString = await rootBundle.loadString('assets/recipes1.json');
    _currentRecipes1 = APIRecipeQuery.fromJson(jsonDecode(jsonString));
    jsonString = await rootBundle.loadString('assets/recipes2.json');
    _currentRecipes2 = APIRecipeQuery.fromJson(jsonDecode(jsonString));
  }

  Future<Response<Result<APIRecipeQuery>>> queryRecipes(
      String query, int from, int to) {
    // 6
    switch (nextRecipe.nextInt(2)) {
      case 0:
        // 7
        return Future.value(
            Response(null, Success<APIRecipeQuery>(_currentRecipes1)));
      case 1:
        return Future.value(
            Response(null, Success<APIRecipeQuery>(_currentRecipes2)));
      default:
        return Future.value(
            Response(null, Success<APIRecipeQuery>(_currentRecipes1)));
    }
  }
}
