import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/blocs/mycart_bloc.dart';
import 'package:flutter_ecommerce_app/screens/my_cart.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CartButton extends StatelessWidget {
  final Function() onPressed;

  const CartButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final cartCounts = context.watch<MyCartBloc>().state.addedCarts.length;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyCartScreen()));
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Badge(
          label: Text("$cartCounts"),
          child: Icon(PhosphorIcons.regular.shoppingCartSimple),
        ),
      ),
    );
  }
}
