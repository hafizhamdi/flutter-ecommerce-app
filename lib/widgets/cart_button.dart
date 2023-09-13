import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CartButton extends StatelessWidget {
  final Function() onPressed;

  const CartButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Badge(
          label: const Text("3"),
          child: Icon(PhosphorIcons.regular.shoppingCartSimple),
        ));
  }
}
