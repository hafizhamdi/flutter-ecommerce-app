import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/widgets/rating.dart';
import '../widgets/widget.dart';
import '../constants/constant.dart';
import '../models/result_product.dart';

class ItemCard extends StatelessWidget {
  final Products data;
  final Function() favOnPressed;
  final bool isFavourite;

  const ItemCard(
      {super.key,
      required this.data,
      required this.favOnPressed,
      required this.isFavourite});
  @override
  Widget build(BuildContext context) {
    final price = data.price;
    final discountPercentage = data.discountPercentage;
    final title = data.title;
    final brand = data.brand;
    final rating = data.rating;
    final priceBeforeDiscount =
        _calcPriceBeforeDiscount(price!, discountPercentage!);

    return Stack(children: [
      Container(
          margin:const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          color: Colors.white,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              //  height : 100,
              child: Image.network(
                data.thumbnail!,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Visibility(
              visible: discountPercentage != 0.0 ? true : false,
              child: Padding(
                padding:const EdgeInsets.only(top: 6, left: 6),
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
            ),
            Padding(
              padding:const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "\$${price.toStringAsFixed(0)}",
                      style:const TextStyle(
                          fontWeight: kFontWeight700, color: Colors.red),
                    ),
                    Rating(rating: rating!)
                    // FavouriteButton(),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
              child: Text(
                "$title",
                style: const TextStyle(fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                "$brand",
                style: const TextStyle(fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ])),
      Positioned(
        left: 10,
        top: 10,
        child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              "-${discountPercentage.toInt()}%",
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.red, fontSize: 10),
            )),
      ),
    ]);
  }

  _calcPriceBeforeDiscount(double price, double discountPercentage) {
    var result = price + (price * discountPercentage / 100);
    return result.toStringAsFixed(2);
  }
}
