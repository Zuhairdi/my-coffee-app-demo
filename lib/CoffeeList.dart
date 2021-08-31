import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_coffee_app/CartProvider.dart';
import 'package:provider/provider.dart';

List<Information> coffeeName = [
  //source https://www.baristainstitute.com/blog/emmi-kinnunen/october-2019/affogato-ristretto-list-most-common-coffee-drinks

  Information(
    'Affogato',
    priceRandomGenerator(10.00, 5.00),
    'assets/coffee/affogato.png',
  ),
  Information(
    'Americano',
    priceRandomGenerator(10.00, 5.00),
    'assets/coffee/americano.png',
  ),
  Information(
    'Caffe Latte',
    priceRandomGenerator(10.00, 5.00),
    'assets/coffee/caffe-latte.png',
  ),
  Information(
    'Caffe Mocha',
    priceRandomGenerator(10.00, 5.00),
    'assets/coffee/caffe-mocha.png',
  ),
  Information(
    'Cafe Au Lait',
    priceRandomGenerator(10.00, 5.00),
    'assets/coffee/caffe-au-lait.png',
  ),
  Information(
    'Cappuccino',
    priceRandomGenerator(10.00, 5.00),
    'assets/coffee/cappucino.png',
  ),
  Information(
    'Cold Brew Coffee',
    priceRandomGenerator(10.00, 5.00),
    'assets/coffee/cold-brew-coffee.png',
  ),
  Information(
    'Double Espresso',
    priceRandomGenerator(10.00, 5.00),
    'assets/coffee/double-espresso.png',
  ),
  Information(
    'Espresso',
    priceRandomGenerator(10.00, 5.00),
    'assets/coffee/espresso.png',
  ),
  Information(
    'Espresson Con Panna',
    priceRandomGenerator(10.00, 5.00),
    'assets/coffee/espresso-con-panna.png',
  ),
  Information(
    'Espresson Macchiato',
    priceRandomGenerator(10.00, 5.00),
    'assets/coffee/espresson-machiato.png',
  ),
  Information(
    'Flat White',
    priceRandomGenerator(10.00, 5.00),
    'assets/coffee/flat-white.png',
  ),
  Information(
    'Frappe',
    priceRandomGenerator(10.00, 5.00),
    'assets/coffee/frappe.png',
  ),
  Information(
    'Freakshake',
    priceRandomGenerator(10.00, 5.00),
    'assets/coffee/freakshake.png',
  ),
  Information(
    'Ice Latte',
    priceRandomGenerator(10.00, 5.00),
    'assets/coffee/ice-latte.png',
  ),
  Information(
    'Ice Mocha',
    priceRandomGenerator(10.00, 5.00),
    'assets/coffee/ice-mocha.png',
  ),
  Information(
    'Irish Coffee',
    priceRandomGenerator(10.00, 5.00),
    'assets/coffee/irish-coffee.png',
  ),
  Information(
    'Latte Macchiato',
    priceRandomGenerator(10.00, 5.00),
    'assets/coffee/latte-macchiato.png',
  ),
  Information(
    'Lungo',
    priceRandomGenerator(10.00, 5.00),
    'assets/coffee/lungo.png',
  ),
  Information(
    'Ristretto',
    priceRandomGenerator(10.00, 5.00),
    'assets/coffee/ristretto.png',
  ),
];

List<Widget> coffeeList() {
  List<Widget> temp = [];
  coffeeName.forEach((Information data) {
    temp.add(ItemList(x: data));
  });
  return temp;
}

class ItemList extends StatefulWidget {
  const ItemList({
    Key? key,
    required this.x,
  }) : super(key: key);

  final Information x;

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.x.itemName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'HinaMincho',
                ),
              ),
            ),
          ),
          Consumer<CartProvider>(
            builder: (_, value, __) => Expanded(
              flex: 5,
              child: Bounce(
                animate: false,
                manualTrigger: true,
                controller: (ctrl) => value.addToAnimationController(ctrl),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Image.asset(widget.x.asset),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Information {
  late String itemName;
  late double price;
  late String asset;
  Information(this.itemName, this.price, this.asset);
}

double priceRandomGenerator(double max, double min) {
  Random r = new Random();
  return min + (max - min) * r.nextDouble();
}
