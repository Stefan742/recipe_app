class MealSummary {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;

  MealSummary({required this.idMeal, required this.strMeal, required this.strMealThumb});

  factory MealSummary.fromJson(Map<String, dynamic> json) => MealSummary(
        idMeal: json['idMeal'] ?? '',
        strMeal: json['strMeal'] ?? '',
        strMealThumb: json['strMealThumb'] ?? '',
      );
}

class MealDetail {
  final String idMeal;
  final String strMeal;
  final String strCategory;
  final String strArea;
  final String strInstructions;
  final String strMealThumb;
  final String? strYoutube;
  final Map<String, String> ingredients;

  MealDetail({
    required this.idMeal,
    required this.strMeal,
    required this.strCategory,
    required this.strArea,
    required this.strInstructions,
    required this.strMealThumb,
    this.strYoutube,
    required this.ingredients,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    final Map<String, String> ingr = {};
    for (var i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient\$i'];
      final measure = json['strMeasure\$i'];
      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        ingr[ingredient.toString()] = measure?.toString() ?? '';
      }
    }
    return MealDetail(
      idMeal: json['idMeal'] ?? '',
      strMeal: json['strMeal'] ?? '',
      strCategory: json['strCategory'] ?? '',
      strArea: json['strArea'] ?? '',
      strInstructions: json['strInstructions'] ?? '',
      strMealThumb: json['strMealThumb'] ?? '',
      strYoutube: json['strYoutube'],
      ingredients: ingr,
    );
  }
}
