class Recipe {
  String chef, recipeName, procedure, prepTime, readTime, ingredients;
  int likes;
  var pubDate;
  Recipe({
    this.chef,
    this.recipeName,
    this.prepTime,
    this.readTime,
    this.ingredients,
    this.procedure,
    this.likes,
    this.pubDate,
  });
}
