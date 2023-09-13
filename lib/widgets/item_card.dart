import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../constants/constant.dart';
import '../models/result_product.dart';

class ItemCard extends StatelessWidget {
  final Products data;

  const ItemCard({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    final price = data.price;
    final discountPercentage = data.discountPercentage;
    final title = data.title;
    final rating = data.rating;
    final priceBeforeDiscount = _calcPriceBeforeDiscount(price!, discountPercentage!);

    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            //  height : 100,
            child: Image.network(
              data.thumbnail!,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Visibility(
            visible: discountPercentage != 0.0? true: false,
            child: Padding(
              padding: EdgeInsets.only(top: 6, left: 6),
              child: RichText(
                text: TextSpan(
                  text: "\$$priceBeforeDiscount",
                  style: new TextStyle(
                    fontSize: 12,
                    color: kPrimaryColor,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 6),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "\$${price.toStringAsFixed(0)}",
                    style: TextStyle(
                        fontWeight: kFontWeight700, color: Colors.red),
                  ),
                  Icon(PhosphorIcons.regular.heart)
                ]),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 6),
            child: Text(
              "Laptop 13 inch 2023",
              style: TextStyle(fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              "Best laptop in town",
              overflow: TextOverflow.ellipsis,
            ),
          )
        ]));
  }

  _calcPriceBeforeDiscount(double price, double discountPercentage) {
    var result = price + (price * discountPercentage/100);
    return result.toStringAsFixed(2);
  }
}
