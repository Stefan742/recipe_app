import 'package:flutter/material.dart';
import 'package:recipe_app/services/api_service.dart';
import 'package:recipe_app/models/meal.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:recipe_app/core/constants.dart';

class MealDetailScreen extends StatefulWidget {
  const MealDetailScreen({super.key});
  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  final ApiService api = ApiService();
  MealDetail? meal;
  bool loading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final id = ModalRoute.of(context)!.settings.arguments as String;
    _load(id);
  }

  Future<void> _load(String id) async {
    final m = await api.lookupMeal(id);
    setState(() { meal = m; loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 300,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Hero(tag: meal!.idMeal, child: CachedNetworkImage(imageUrl: meal!.strMealThumb, fit: BoxFit.cover)),
                        Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.black.withOpacity(0.4), Colors.transparent], begin: Alignment.bottomCenter, end: Alignment.topCenter))),
                      ],
                    ),
                  ),
                  actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)), IconButton(onPressed: () {}, icon: const Icon(Icons.share))],
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(meal!.strMeal, style: Theme.of(context).textTheme.headlineSmall),
                          const SizedBox(height: 8),
                          Row(children: [Chip(label: Text(meal!.strCategory)), const SizedBox(width: 8), Chip(label: Text(meal!.strArea))]),
                          const SizedBox(height: 16),
                          Text('Ingredients', style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: meal!.ingredients.entries.map((e) => Chip(label: Text('\${e.key} — \${e.value}'))).toList(),
                          ),
                          const SizedBox(height: 16),
                          Text('Instructions', style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 8),
                          Text(meal!.strInstructions, style: const TextStyle(height: 1.6)),
                          const SizedBox(height: 20),
                          if (meal!.strYoutube != null && meal!.strYoutube!.isNotEmpty)
                            ElevatedButton.icon(
                              onPressed: () => launchUrl(Uri.parse(meal!.strYoutube!)),
                              icon: const Icon(Icons.play_arrow),
                              label: const Text('Watch on YouTube'),
                            ),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ]),
                )
              ],
            ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(12),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), backgroundColor: AppColors.primary),
          child: const Text('Start cooking', style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
