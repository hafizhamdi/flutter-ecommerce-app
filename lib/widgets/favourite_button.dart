import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FavouriteButton extends StatefulWidget {
  const FavouriteButton({super.key});

  @override
  _FavouriteButton createState() => _FavouriteButton();
}

class _FavouriteButton extends State<FavouriteButton> {
  double scale = 1.0;

  void _changeScale() {
    setState(() => scale = scale == 1.0 ? 1.2 : 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _changeScale,
      child: AnimatedScale(
        scale: scale,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 100),
        child: Icon(scale == 1.0
            ? PhosphorIcons.regular.heart
            : PhosphorIcons.fill.heart),
      ),
    );
  }
}
