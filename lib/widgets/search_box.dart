import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/constants/color.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10)),
        child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ThemeData().colorScheme.copyWith(
                    primary: kPrimaryColor,
                  ),
            ),
            child: TextFormField(
              
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: 'Search here',
                  border: InputBorder.none,
                  fillColor: Colors.red,
                  prefixIcon: Icon(PhosphorIcons.regular.magnifyingGlass)),
            )));
  }
}
