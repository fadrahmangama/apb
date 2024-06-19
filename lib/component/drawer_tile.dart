import 'package:apb/services/auth/auth_services.dart';
import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final String text;
  final IconData? icon;
  final void Function()? onTap;

  const DrawerTile({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  void logout() {
	final authService = AuthService();
	authService.signOut();
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        onTap: onTap,
      ),
    );
  }
}
