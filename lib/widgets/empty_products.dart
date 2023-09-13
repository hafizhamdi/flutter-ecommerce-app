import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EmptyProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 100,),
        Icon(PhosphorIcons.regular.binoculars, size: 40,),
        SizedBox(
          height: 10,
        ),
        const Text("No product at the moment")
      ]),
    );
  }
}
