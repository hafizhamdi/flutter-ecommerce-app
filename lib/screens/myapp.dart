import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/blocs/product_bloc.dart';
import 'package:flutter_ecommerce_app/constants/constant.dart';
import 'package:flutter_ecommerce_app/widgets/empty_products.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../widgets/widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: kPrimaryColor,
              centerTitle: true,
              title: const Text("Shopping Mart",
                  style: TextStyle(
                      color: kPrimaryTextColor,
                      fontSize: kHeader1FontSize,
                      fontWeight: kFontWeight700)),
              actions: [CartButton(onPressed: () {})],
            ),
            SliverToBoxAdapter(child: SearchBox()),
            BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
              if (state is LoadedProduct) {
                final data = state.data.products;

                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,

                    mainAxisSpacing: 10.0,
                    // crossAxisSpacing: 10.0,
                    childAspectRatio: 0.8,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return ItemCard(data: data[index]);
                    },
                    childCount: data!.length,
                  ),
                );
              }
              return SliverToBoxAdapter(child: EmptyProducts());
            })
          ],
        ),
      ),
    );
  }
}

class SearchResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: 300,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.amber,
              child: Center(child: Text('$index')),
            );
          }),
    );
  }
}
