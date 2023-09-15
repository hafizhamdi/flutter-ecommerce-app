import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/blocs/mycart_bloc.dart';
import 'package:flutter_ecommerce_app/constants/color.dart';
import 'package:flutter_ecommerce_app/models/result_product.dart';
import 'package:flutter_ecommerce_app/widgets/add_to_cart.dart';
import 'package:flutter_ecommerce_app/widgets/favourite_button.dart';

import '../constants/font.dart';
import '../widgets/rating.dart';

class ProductDetailScreen extends StatelessWidget {
  final Products item;

  const ProductDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProductBody(item: item),
    );
  }
}

class ProductBody extends StatelessWidget {
  final Products item;

  const ProductBody({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      const SliverAppBar(
        backgroundColor: kPrimaryColor,
        // centerTitle: true,

        // actions: [CartButton(onPressed: () {})
      ),
      SliverToBoxAdapter(child: ProductImageSlider(imgList: item.images!)),
      SliverToBoxAdapter(
          child: ProductDescription(
        item: item,
      ))
    ]);
  }
}

class ProductImageSlider extends StatelessWidget {
  final List<String> imgList;

  const ProductImageSlider({super.key, required this.imgList});

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = imgList
        .map(
          (item) => Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          '#${imgList.indexOf(item) + 1} ',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        )
        .toList();
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
        autoPlay: true,
      ),
      items: imageSliders,
    );
  }
}

class ProductDescription extends StatelessWidget {
  final Products item;

  const ProductDescription({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final price = item.price;
    final discountPercentage = item.discountPercentage;
    final rating = item.rating;

    final priceBeforeDiscount =
        _calcPriceBeforeDiscount(price!, discountPercentage!);
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: discountPercentage != 0.0 ? true : false,
              child: RichText(
                text: TextSpan(
                  text: "\$$priceBeforeDiscount",
                  style: const TextStyle(
                    fontSize: 12,
                    color: kPrimaryColor,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "\$${price.toStringAsFixed(0)}",
                    style: const TextStyle(
                        fontWeight: kFontWeight700, color: Colors.red),
                  ),
                  Row(children: [
                    Rating(rating: rating!),
                    const SizedBox(
                      width: 10,
                    ),
                    const FavouriteButton()
                  ])
                  // FavouriteButton(),
                ]),
            Text(
              item.title!,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
              item.description!,
              style: TextStyle(color: Colors.grey.shade500),
            ),
            const SizedBox(
              height: 30,
            ),
            AddToCart(onPressed: () {
              context.read<MyCartBloc>().add(AddCart(cart: item));

              final snackBar = SnackBar(
                content: Text('1 item added in cart'),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);

              Navigator.pop(context);
            })
          ],
        ));
  }

  _calcPriceBeforeDiscount(double price, double discountPercentage) {
    var result = price + (price * discountPercentage / 100);
    return result.toStringAsFixed(2);
  }
}
