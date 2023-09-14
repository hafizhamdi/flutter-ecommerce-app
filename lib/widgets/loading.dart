import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/constants/color.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
          height: 100,
        ),
        Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
          ),
        ),
      ]),
    );
  }
}
