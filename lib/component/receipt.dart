import 'package:flutter/material.dart';
import 'package:apb/models/cart_item.dart'; // Ensure this import is correct

class ReceiptPage extends StatelessWidget {
  final DateTime dateTime;
  final List<CartItem> items;

  ReceiptPage({Key? key, required this.dateTime, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    int totalItems = 0;

    for (var item in items) {
      totalPrice += item.totalPrice;
      totalItems += item.quantity;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery in progress..'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Thank you for your order!',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Here\'s your receipt..',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                dateTime.toString(),
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 20),
              ...items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.quantity} x ${item.food.name} - \$${item.food.price.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 16),
                    ),
                    if (item.selectedAddons.isNotEmpty)
                      ...item.selectedAddons.map((addon) => Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          '${addon.name} (\$${addon.price.toStringAsFixed(2)})',
                          style: TextStyle(fontSize: 14),
                        ),
                      )).toList(),
                  ],
                ),
              )).toList(),
              Divider(),
              Text(
                'Total Items: $totalItems',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
