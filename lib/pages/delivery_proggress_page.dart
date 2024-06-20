import 'package:apb/component/receipt.dart';
import 'package:flutter/material.dart';

class DeliveryProggressPage extends StatelessWidget {
  const DeliveryProggressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery in proggress.."),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Receipt(),
        ],
      ),
    );
  }
}
