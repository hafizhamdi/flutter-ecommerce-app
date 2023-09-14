import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/constants/constant.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Rating extends StatelessWidget{
  final double rating;
  Rating({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(PhosphorIcons.fill.star, color: Colors.yellow, size: 14,),
      const SizedBox(width: 5,),
      Text("${rating.toStringAsFixed(1)}", style: const TextStyle(fontWeight: kFontWeight700, fontSize: 12),)

    ],);
  }
}