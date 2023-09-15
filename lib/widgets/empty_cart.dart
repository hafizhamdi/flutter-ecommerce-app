import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         const SizedBox(height: 100,),
        Icon(PhosphorIcons.regular.bag, size: 40,),
        const SizedBox(
          height: 10,
        ),
        const Text("You're cart still empty, add one")
      ]),
    );
  }
}
