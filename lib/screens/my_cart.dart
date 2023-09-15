import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/blocs/mycart_bloc.dart';
import 'package:flutter_ecommerce_app/services/local_nofitication.dart';
import 'package:flutter_ecommerce_app/widgets/widget.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../constants/color.dart';
import '../models/result_product.dart';
import '../widgets/pay_button.dart';

class MyCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final listProducts = context.watch<MyCartBloc>().state.addedCarts;
    return Scaffold(
        body: CustomScrollView(slivers: [
      const SliverAppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text("My Cart", style: TextStyle(color: Colors.white)),
      ),

      //   // actions: [CartButton(onPressed: () {})
      // ),
      BlocBuilder<MyCartBloc, MyCartState>(builder: (context, state) {
        if (state.addedCarts.isNotEmpty) {
          debugPrint(state.addedCarts.length.toString());
          return SliverCartList(listProducts: state.addedCarts);
        }
        return const SliverToBoxAdapter(child: EmptyCart());
      }),

      const SliverToBoxAdapter(
          child: SizedBox(
        height: 20,
      )),

      SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child:PayButton(
        onPressed: () {},
      )))
    ]));
  }
}

class SliverCartList extends StatelessWidget {
  List<Products> listProducts;

  SliverCartList({super.key, required this.listProducts});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemCount: listProducts.length,
        itemBuilder: (context, index) {
          final item = listProducts[index];
          return ListTile(
            leading: SizedBox(
              height: 50,
              width: 50,
              child: Image.network(item.thumbnail!),
            ),
            title: Text(item.title!),
            subtitle: Text("\$${item.price!.toStringAsFixed(2)}"),
            trailing: IconButton(
                icon: Icon(
                  PhosphorIcons.regular.trash,
                  color: kPrimaryColor,
                ),
                onPressed: () async {
                  context.read<MyCartBloc>().add(RemoveCart(index: index));

                  final snackBar = SnackBar(
                    content: Text('1 item removed in cart'),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  LocalNotification.localNotification.showLocalNotification(
                      "Item Cart is removed", "${item.title} is removed");
                }),
          );
        });
  }
}
