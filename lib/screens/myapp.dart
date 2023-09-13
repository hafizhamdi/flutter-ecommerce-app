import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/blocs/product_bloc.dart';
import 'package:flutter_ecommerce_app/constants/constant.dart';
import 'package:flutter_ecommerce_app/widgets/empty_products.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../widgets/widget.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  List<int> _listFavourite = [];
  TextEditingController _searchController = TextEditingController();
  String _searchText = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
            SliverToBoxAdapter(
                child: SearchBox(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
            )),
            BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
              if (state is LoadedProduct) {
                final products = state.data.products;
                final data = products!
                    .where((e) => "${e.brand},${e.title},${e.description}"
                        .toLowerCase()
                        .contains(_searchText.toLowerCase()))
                    .toList();

                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,

                    mainAxisSpacing: 10.0,
                    // crossAxisSpacing: 10.0,
                    childAspectRatio: 0.9,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return ItemCard(
                        isFavourite: _listFavourite.contains(data[index].id),
                        data: data[index],
                        favOnPressed: () {
                          setState(() {
                            if (!_listFavourite.contains(data[index].id)) {
                              _listFavourite.add(data[index].id!);
                            } else {
                              _listFavourite.remove(data[index].id);
                            }
                          });
                        },
                      );
                    },
                    childCount: data!.length,
                  ),
                );
              }
              return const SliverToBoxAdapter(child: EmptyProducts());
            })
          ],
        ),
      ),
    );
  }
}

class SearchResult extends StatelessWidget {
  const SearchResult({super.key});

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
