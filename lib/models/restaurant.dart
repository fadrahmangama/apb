import 'package:apb/models/cart_item.dart';
import 'package:apb/models/food.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  List<CartItem> get cart => _cart;

  //OPERATIONS

  //user cart
  final List<CartItem> _cart = [];

  //add to cart
  void addToCart(Food food, List<Addon> selectedAddons) {
    //see if there is a cart item already with the same food and selected addons
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      // check if the food items are the same
      bool isSameFood = item.food == food;

      //check if the list of selected addons are the same
      bool isSameAddons =
          ListEquality().equals(item.selectedAddons, selectedAddons);

      return isSameFood && isSameAddons;
    });

    // if item alrady exists, increase it's quantity
    if (cartItem != null) {
      cartItem.quantity++;
    }

    // otherwhise, add a new cart item to the cart
    else {
      _cart.add(
        CartItem(
          food: food,
          selectedAddons: selectedAddons,
        ),
      );
    }
    notifyListeners();
  }

  //remove item from cart
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }

    notifyListeners();
  }

  //get total price
  double getTotalPrice() {
    double total = 0.0;

    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;

      for (Addon addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }

      total += itemTotal * cartItem.quantity;
    }

    return total;
  }

  //get total number of items in carts
  int getTotalItemCount() {
    int totalItemCount = 0;
    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }

    return totalItemCount;
  }

  //clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  //HELPERS

  // generate a receipt
  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("Here's your receipt..");
    receipt.writeln();

    // format the date to include up to seconds only
    String formattedDate =
        DateFormat('yyyy-mm-dd HH:mm:ss').format(DateTime.now());

    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("===========");

    for (final CartItem in _cart) {
      receipt.writeln(
          "${CartItem.quantity} x ${CartItem.food.name} - ${_formatPrice(CartItem.food.price)}");
      if (CartItem.selectedAddons.isNotEmpty) {
        receipt
            .writeln("   Add-ons: ${_formatAddons(CartItem.selectedAddons)}");
      }
      receipt.writeln();
    }

    receipt.writeln("==============");
    receipt.writeln();
    receipt.writeln("Total Items: ${getTotalItemCount()}");
    receipt.writeln("Total Price: ${_formatPrice(getTotalPrice())}");

    return receipt.toString();
  }

  //format double value into money
  String _formatPrice(double price) {
    return "Rp. ${price.toStringAsFixed(3)}";
  }

  //format list of addons into a string summary
  String _formatAddons(List<Addon> addons) {
    return addons
        .map((addon) => "${addon.name} (${_formatPrice(addon.price)})")
        .join(", ");
  }
}
