import 'package:flutter/material.dart';
import 'package:recipe_app/services/api_service.dart';
import 'package:recipe_app/widgets/category_card.dart';
import 'package:recipe_app/models/category.dart';
import 'package:recipe_app/core/constants.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final ApiService api = ApiService();
  List<Category> categories = [];
  List<Category> filtered = [];
  bool loading = true;
  String query = '';

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final cats = await api.getCategories();
      setState(() {
        categories = cats;
        filtered = cats;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
    }
  }

  void _onSearch(String q) {
    setState(() {
      query = q;
      filtered = categories.where((c) => c.strCategory.toLowerCase().contains(q.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('Recipes'),
        actions: [
          IconButton(onPressed: () async {
            // open random
            Navigator.pushNamed(context, '/random');
          }, icon: const Icon(Icons.shuffle)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  TextField(onChanged: _onSearch, decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search categories...')),
                  const SizedBox(height: 12),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.1),
                      itemCount: filtered.length,
                      itemBuilder: (context, idx) => CategoryCard(
                        category: filtered[idx],
                        onTap: () => Navigator.pushNamed(context, '/category', arguments: filtered[idx].strCategory),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
