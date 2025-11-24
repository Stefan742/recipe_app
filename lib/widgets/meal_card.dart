import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/models/meal.dart';

class MealCard extends StatelessWidget {
  final MealSummary meal;
  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/meal', arguments: meal.idMeal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Hero(
                tag: meal.idMeal,
                child: CachedNetworkImage(
                  imageUrl: meal.strMealThumb,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (c, u) => Container(color: Colors.grey[200]),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(meal.strMeal, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
