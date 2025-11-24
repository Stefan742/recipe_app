import 'package:flutter/material.dart';
import 'package:recipe_app/theme/app_theme.dart';
import 'package:recipe_app/screens/categories_screen.dart';
import 'package:recipe_app/screens/category_meals_screen.dart';
import 'package:recipe_app/screens/meal_detail_screen.dart';
import 'package:recipe_app/screens/random_meal_screen.dart';

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: appTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => const CategoriesScreen(),
        '/category': (context) => const CategoryMealsScreen(),
        '/meal': (context) => const MealDetailScreen(),
        '/random': (context) => const RandomMealScreen(),
      },
    );
  }
}
