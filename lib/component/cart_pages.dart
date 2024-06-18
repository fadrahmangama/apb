import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apb/component/cart_tile.dart';
import 'package:apb/component/sign_in_button.dart';
import 'package:apb/models/restaurant.dart';
import 'package:apb/pages/payment_page.dart';
import 'package:apb/pages/receipt.dart'; // Import the ReceiptPage

class CartPages extends StatelessWidget {
  const CartPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        // cart
        final userCart = restaurant.cart;

        // scaffold UI
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Cart", style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              // clear cart button
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Are you sure want to clear the cart?"),
                      actions: [
                        // cancel button
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        // yes button
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            restaurant.clearCart();
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.delete_outline),
              )
            ],
          ),
          body: Column(
            children: [
              // list of cart
              Expanded(
                child: userCart.isEmpty
                    ? const Center(
                        child: Text("Cart is empty"),
                      )
                    : ListView.builder(
                        itemCount: userCart.length,
                        itemBuilder: (context, index) {
                          // get individual cart item
                          final cartItem = userCart[index];

                          // return cart tile UI
                          return CartTile(cartItem: cartItem);
                        },
                      ),
              ),

              // button to pay with bottom margin
              if (userCart.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SignInButton(
                    text: "Go to checkout",
                    onTap: () {
                      // Navigate to PaymentPage and then ReceiptPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(),
                        ),
                      ).then((_) {
                        // Assuming the payment is successful and you want to show the receipt
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReceiptPage(
                              dateTime: DateTime.now(),
                              items: userCart,
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
