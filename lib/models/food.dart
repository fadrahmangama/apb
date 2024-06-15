class Food {
  final String name; // cheese burger
  final String description; // a burger full of cheese
  final String imagePath; // lib/images/cheese_burger
  final double price; // 50.000
  final FoodCategory category; // burger
  List<Addon> avaibleAddons; // 1 extra cheese, extra patty !

  Food({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category,
    required this.avaibleAddons,
  });
}

// food category
enum FoodCategory {
  Burgers,
  Mains,
  Drinks,
}

// food addons
class Addon {
  String name;
  double price;

  Addon({
    required this.name,
    required this.price,
  });
}
