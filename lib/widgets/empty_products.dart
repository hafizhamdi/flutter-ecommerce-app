import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EmptyProducts extends StatelessWidget {
  const EmptyProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         const SizedBox(height: 100,),
        Icon(PhosphorIcons.regular.binoculars, size: 40,),
        const SizedBox(
          height: 10,
        ),
        const Text("Let's try search a new keyword")
      ]),
    );
  }
}
