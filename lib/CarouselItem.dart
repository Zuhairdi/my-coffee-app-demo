import 'package:flutter/material.dart';
import 'package:my_coffee_app/CoffeeList.dart';

class CarouselItem extends StatelessWidget {
  final Information data;
  const CarouselItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white60,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Container(
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(data.asset),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ListTile(
                  title: Container(
                    color: Colors.white54,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data.itemName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontFamily: 'HinaMincho',
                          fontSize: 22,
                          height: 0.9,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DessertAppBar extends StatelessWidget {
  final VoidCallback onReturnPressed;
  const DessertAppBar({Key? key, required this.onReturnPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Fancy some desserts?',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            onPressed: () {
              onReturnPressed();
            },
            icon: Icon(Icons.cancel_presentation),
          ),
        ),
      ],
    );
  }
}
