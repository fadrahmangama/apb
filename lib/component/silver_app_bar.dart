import 'package:apb/pages/cart_pages.dart';
import 'package:flutter/material.dart';

class SilverAppBar extends StatelessWidget {
  final Widget child;
  final Widget title;

  const SilverAppBar({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text(
        "Sunset Dinner",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'sans-serif',
        ),
      ),
      expandedHeight: 340,
      collapsedHeight: 120,
      floating: false,
      pinned: true,
      actions: [
        // cart button
        IconButton(
          onPressed: () {
            // go to cart page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartPages(),
              ),
            );
          },
          icon: const Icon(Icons.shopping_cart_outlined),
        )
      ],
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: child,
        ),
        title: title,
        centerTitle: true,
        titlePadding: const EdgeInsets.only(left: 0, right: 0, top: 0),
        expandedTitleScale: 1,
      ),
    );
  }
}
