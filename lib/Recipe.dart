class Recipe {
  double calories;
  int likes, totalTime, yieldQ;
  String name, image;
  List<dynamic> ingredients, dietLabels, healthLabels;
  Map<dynamic, dynamic> totalNutrients;
  Recipe({
    this.calories,
    this.ingredients,
    this.totalNutrients,
    this.likes,
    this.image,
    this.totalTime,
    this.name,
    this.dietLabels,
    this.yieldQ,
    this.healthLabels,
  });
}
