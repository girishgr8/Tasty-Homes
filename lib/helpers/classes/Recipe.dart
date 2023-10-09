class Recipe {
  int cookingMinutes, preparationMinutes, servings, likes;
  String imageUrl, summary, title;
  bool vegetarian;
  List<dynamic> ingredients, cuisines, diets, dishTypes, procedure;
  Recipe({
    required this.cookingMinutes,
    required this.cuisines,
    required this.diets,
    required this.dishTypes,
    required this.imageUrl,
    required this.ingredients,
    required this.likes,
    required this.preparationMinutes,
    required this.procedure,
    required this.servings,
    required this.summary,
    required this.title,
    required this.vegetarian,
  });
}
