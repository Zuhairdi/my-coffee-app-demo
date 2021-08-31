import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:my_coffee_app/AddOnList.dart';
import 'package:my_coffee_app/CartProvider.dart';
import 'package:my_coffee_app/MainProvider.dart';
import 'package:provider/provider.dart';

class MyCarouselOptions extends CarouselOptions {
  final BuildContext context;
  MyCarouselOptions(this.context)
      : super(
          height: 300,
          //aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 5),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.elasticInOut,
          onPageChanged: (index, reason) {
            //when desserts scroll change
            Provider.of<CartProvider>(context, listen: false).selection =
                addOnName[index];
            Provider.of<MainProvider>(context, listen: false).itemPrice =
                addOnName[index].price;
          },
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        );
}
