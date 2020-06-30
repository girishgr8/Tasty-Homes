class Recipe {
  int cookingMinutes, preparationMinutes, servings, likes;
  String imageUrl, summary, title;
  bool vegetarian;
  List<dynamic> ingredients, cuisines, diets, dishTypes, procedure;
  Recipe({
    this.cookingMinutes,
    this.cuisines,
    this.diets,
    this.dishTypes,
    this.imageUrl,
    this.ingredients,
    this.likes,
    this.preparationMinutes,
    this.procedure,
    this.servings,
    this.summary,
    this.title,
    this.vegetarian,
  });
}
