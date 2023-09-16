import 'package:flutter/material.dart';

class SearchFeedback extends StatelessWidget {
  final Icon icon;
  final String alertMessage;

  const SearchFeedback({super.key, required this.icon, required this.alertMessage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         const SizedBox(height: 100,),
        icon,
        const SizedBox(
          height: 10,
        ),
         Text(alertMessage, textAlign: TextAlign.center,)
      ]),
    );
  }
}
