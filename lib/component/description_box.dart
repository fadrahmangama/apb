import 'package:flutter/material.dart';

class DescriptionBox extends StatelessWidget {
  const DescriptionBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // textstyle
    var MyPrimaryTextStyle =
        TextStyle(color: Theme.of(context).colorScheme.inversePrimary);
    var MySecondaryTextStyle =
        TextStyle(color: Theme.of(context).colorScheme.primary);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(25.0),
      margin: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // delivery fee
          Column(
            children: [
              Text(
                'Rp.15.000',
                style: MyPrimaryTextStyle,
              ),
              Text(
                'Delivery fee',
                style: MySecondaryTextStyle,
              ),
            ],
          ),
          //delivery time
          Column(
            children: [
              Text(
                '15-30 min',
                style: MyPrimaryTextStyle,
              ),
              Text(
                'Delivery time',
                style: MySecondaryTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
