import 'package:flutter/material.dart';
import 'package:recipe_app/services/api_service.dart';
import 'package:recipe_app/models/meal.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RandomMealScreen extends StatefulWidget {
  const RandomMealScreen({super.key});

  @override
  State<RandomMealScreen> createState() => _RandomMealScreenState();
}

class _RandomMealScreenState extends State<RandomMealScreen> {
  final ApiService api = ApiService();
  MealDetail? meal;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final m = await api.randomMeal();
    setState(() { meal = m; loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Recipe')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  CachedNetworkImage(imageUrl: meal!.strMealThumb, width: double.infinity, height: 240, fit: BoxFit.cover),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(meal!.strMeal, style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 12),
                      Text(meal!.strInstructions, style: const TextStyle(height: 1.6)),
                    ]),
                  )
                ],
              ),
            ),
    );
  }
}
