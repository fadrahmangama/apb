import 'package:apb/models/food.dart';
import 'package:flutter/material.dart';

class Restaurant extends ChangeNotifier {
  // list of food menu
  final List<Food> _menu = [
    //burgers
    Food(
      name: 'Classic Cheeseburger',
      description: 'tasty classic cheeseburger with lettuce,tomato,etc',
      imagePath: 'lib/images/burgers/delicious-burger-city.jpg',
      price: 30.000,
      category: FoodCategory.Burgers,
      avaibleAddons: [
        Addon(name: 'Extra cheese', price: 5.000),
        Addon(name: 'Extra sauce', price: 3.000),
        Addon(name: 'Bacon', price: 15.000),
      ],
    ),

    Food(
      name: 'Bacon Cheeseburger',
      description: 'tasty bacon cheeseburger with lettuce,tomato,etc',
      imagePath: 'lib/images/burgers/view-3d-burgers-with-nature-scenery.jpg',
      price: 40.000,
      category: FoodCategory.Burgers,
      avaibleAddons: [
        Addon(name: 'Extra cheese', price: 5.000),
        Addon(name: 'Extra sauce', price: 3.000),
        Addon(name: 'Bacon', price: 15.000),
      ],
    ),

    Food(
      name: 'Seafood bowl',
      description:
          'tasty seafood bowl with shrimp, fish, chicken, and thai sauce',
      imagePath:
          'lib/images/mains/spaghetti-on-the-dish-with-ai-generated-free-photo.jpg',
      price: 45.000,
      category: FoodCategory.Mains,
      avaibleAddons: [
        Addon(name: 'Extra sauce', price: 5.000),
        Addon(name: 'Crab', price: 25.000),
      ],
    ),

    Food(
      name: 'Meatlove',
      description: 'Meatlove include beef, and british sauce',
      imagePath:
          'lib/images/mains/spicy-biryani-rice-dishes-pakistan-ai-generated_616879-1212.jpg',
      price: 30.000,
      category: FoodCategory.Mains,
      avaibleAddons: [
        Addon(name: 'Extra cheese', price: 5.000),
        Addon(name: 'Salads', price: 7.000),
      ],
    ),
    //mains
  ];

  //GETTERS

  List<Food> get menu => _menu;

  //OPERATIONS

  //add to cart

  //remove from cart

  //get total price

  //get total number of items in carts

  //clear cart

  //HELPERS

  // generate receipt

  //format double value into money

  //format list of addons into a string summary
}
