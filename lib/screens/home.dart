import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/blocs/product_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../constants/constant.dart';
import '../widgets/widget.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productBloc = Provider.of<ProductBloc>(context);

    return Scaffold(
      drawer: SideDrawer(),
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
            onEditingComplete: () {
              setState(() {
                _searchText = _searchController.text;
              });

              productBloc.add(SearchedAllProduct(query: _searchText));
            },
          )),
          const SliverToBoxAdapter(child: Category()),
          const SliverToBoxAdapter(
              child: SizedBox(
            height: 10,
          )),
          BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
            final size = MediaQuery.of(context).size;
            if (state is LoadedProduct) {
              final data = state.data!.products;

              //search not found
              if (state.data!.total == 0) {
                return SliverToBoxAdapter(
                    child: SearchFeedback(
                  icon: Icon(PhosphorIcons.regular.binoculars, size: 40),
                  alertMessage:
                      "Search not found,\n Please try another keyword",
                ));
              }
              return SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: size.width > 500 ? 4 : 2,

                  mainAxisSpacing: 10.0,
                  // crossAxisSpacing: 10.0,
                  childAspectRatio: 0.9,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ItemCard(
                      data: data[index],
                    );
                  },
                  childCount: data!.length,
                ),
              );
            } else if (state is LoadingProduct) {
              return const SliverToBoxAdapter(child: Loading());
            } else if (state is ErrorProduct) {
              return SliverToBoxAdapter(
                  child: SearchFeedback(
                icon: Icon(PhosphorIcons.regular.wifiSlash, size: 40),
                alertMessage:
                    "No internet access,\n please check your internet connection\n or try again",
              ));
            }

            return SliverToBoxAdapter(
                child: SearchFeedback(
              icon: Icon(PhosphorIcons.regular.binoculars, size: 40),
              alertMessage: "Lets search what you want",
            ));
          })
        ],
      ),
    );
  }
}
