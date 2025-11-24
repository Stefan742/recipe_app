import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_app/models/category.dart';
import 'package:recipe_app/models/meal.dart';

class ApiService {
  static const _base = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<Category>> getCategories() async {
    final res = await http.get(Uri.parse('$_base/categories.php'));
    if (res.statusCode == 200) {
      final body = json.decode(res.body);
      final list = body['categories'] as List;
      return list.map((e) => Category.fromJson(e)).toList();
    }
    throw Exception('Failed to load categories');
  }

  Future<List<MealSummary>> getMealsByCategory(String category) async {
    final res = await http.get(Uri.parse('$_base/filter.php?c=\$category'.replaceFirst('\$category', Uri.encodeComponent(category))));
    if (res.statusCode == 200) {
      final body = json.decode(res.body);
      final list = body['meals'] as List?;
      if (list == null) return [];
      return list.map((e) => MealSummary.fromJson(e)).toList();
    }
    throw Exception('Failed to load meals');
  }

  Future<List<MealSummary>> searchMeals(String query) async {
    final res = await http.get(Uri.parse('$_base/search.php?s=\$query'.replaceFirst('\$query', Uri.encodeComponent(query))));
    if (res.statusCode == 200) {
      final body = json.decode(res.body);
      final list = body['meals'] as List?;
      if (list == null) return [];
      return list.map((e) => MealSummary.fromJson(e)).toList();
    }
    throw Exception('Failed to search meals');
  }

  Future<MealDetail?> lookupMeal(String id) async {
    final res = await http.get(Uri.parse('$_base/lookup.php?i=\$id'.replaceFirst('\$id', Uri.encodeComponent(id))));
    if (res.statusCode == 200) {
      final body = json.decode(res.body);
      final list = body['meals'] as List?;
      if (list == null) return null;
      return MealDetail.fromJson(list.first);
    }
    throw Exception('Failed to lookup meal');
  }

  Future<MealDetail?> randomMeal() async {
    final res = await http.get(Uri.parse('$_base/random.php'));
    if (res.statusCode == 200) {
      final body = json.decode(res.body);
      final list = body['meals'] as List?;
      if (list == null) return null;
      return MealDetail.fromJson(list.first);
    }
    throw Exception('Failed to load random meal');
  }
}
