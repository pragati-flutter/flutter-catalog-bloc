import 'package:flutter/material.dart';
class CartDependencies extends StatelessWidget {
  final Widget child;
  const CartDependencies({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child; // BlocProvider.value handles it in AppRoutes
  }
}