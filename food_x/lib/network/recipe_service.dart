import 'package:http/http.dart';

const String apiKey = 'd6838ad70089458f41674f3a983dc20d';
const String apiId = 'f6490a30';
const String apiUrl = 'https://api.edamam.com/search';

// 1
Future getData(String url) async {
  // 2
  print('Calling url: $url');
  // 3
  final response = await get(url);
  // 4
  if (response.statusCode == 200) {
    // 5
    return response.body;
  } else {
    // 6
    print(response.statusCode);
  }
}

class RecipeService {
  // 1
  Future<dynamic> getRecipes(String query, int from, int to) async {
    // 2
    final recipeData = await getData(
        '$apiUrl?app_id=$apiId&app_key=$apiKey&q=$query&from=$from&to=$to');
    // 3
    return recipeData;
  }
}

