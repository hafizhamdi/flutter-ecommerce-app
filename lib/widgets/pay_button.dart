import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ecommerce_app/constants/constant.dart';

class PayButton extends StatelessWidget {
  final Function() onPressed;
  const PayButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: kPrimaryColor, foregroundColor: Colors.white),
        onPressed: onPressed,
        child: const Text("PAY"),
      ),
    );
  }
}
