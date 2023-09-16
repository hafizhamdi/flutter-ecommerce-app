import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/blocs/product_bloc.dart';
import 'package:flutter_ecommerce_app/constants/color.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    final productBloc = Provider.of<ProductBloc>(context);

    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      if (state is LoadedProduct && state.categories!.isNotEmpty) {
        final categories = state.categories;
        return SizedBox(
            height: 30,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories!.length,
                itemBuilder: (context, index) {
                  final item = _getCategoryItem(categories[index]);

                  return Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            // side: const BorderSide(width: 2, color: Colors.green),
                          ),
                          onPressed: () {
                            productBloc.add(SearchedByCategory(
                                category: categories[index]));
                          },
                          icon: item.icon,
                          label: Text("${item.title}")));
                }));
      }
      return Container();
    });
  }

  _getCategoryItem(String key) {
    final newName = _changeName(key);

    switch (key) {
      case 'laptops':
        return CatItem(
            title: newName, icon: Icon(PhosphorIcons.regular.laptop));
      case 'smartphones':
        return CatItem(title: newName, icon: Icon(PhosphorIcons.regular.deviceMobile));
      case 'fragrances':
        return CatItem(
            title: newName, icon: Icon(PhosphorIcons.regular.orangeSlice));
      case 'skincare':
        return CatItem(
            title: newName, icon: Icon(PhosphorIcons.regular.eyeClosed));
      case 'groceries':
        return CatItem(
            title: newName, icon: Icon(PhosphorIcons.regular.storefront));
      case 'home-decoration':
        return CatItem(
            title: newName, icon: Icon(PhosphorIcons.regular.wrench));
      case 'furniture':
        return CatItem(
            title: newName, icon: Icon(PhosphorIcons.regular.armchair));
      case 'tops':
        return CatItem(
            title: newName, icon: Icon(PhosphorIcons.regular.baseballCap));

      default:
        return CatItem(title: newName, icon: Icon(PhosphorIcons.regular.alien));
    }
  }

  //change first letter to capital
  _changeName(String key) {
    var space = key.replaceAll('-', ' ');
    var capitalFirst =
        "${space.characters.characterAt(0).toUpperCase()}${space.substring(1)}";

    return capitalFirst;
  }
}

class CatItem {
  final String title;
  final Icon icon;

  CatItem({required this.icon, required this.title});
}
