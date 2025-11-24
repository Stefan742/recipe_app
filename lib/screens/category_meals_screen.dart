import 'package:flutter/material.dart';
import 'package:recipe_app/services/api_service.dart';
import 'package:recipe_app/models/meal.dart';
import 'package:recipe_app/widgets/meal_card.dart';
import 'package:recipe_app/core/constants.dart';

class CategoryMealsScreen extends StatefulWidget {
  const CategoryMealsScreen({super.key});
  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  final ApiService api = ApiService();
  List<MealSummary> meals = [];
  List<MealSummary> filtered = [];
  bool loading = true;
  String query = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final category = ModalRoute.of(context)!.settings.arguments as String;
    _loadMeals(category);
  }

  Future<void> _loadMeals(String category) async {
    try {
      final m = await api.getMealsByCategory(category);
      setState(() {
        meals = m;
        filtered = m;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
    }
  }

  void _onSearch(String q) {
    setState(() {
      query = q;
      filtered = meals.where((m) => m.strMeal.toLowerCase().contains(q.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meals')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  TextField(onChanged: _onSearch, decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search meals...')),
                  const SizedBox(height: 12),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.9),
                      itemCount: filtered.length,
                      itemBuilder: (context, idx) => MealCard(meal: filtered[idx]),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
