import 'package:flutter/material.dart';

Future<void> showSuccessDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 5.0,
        contentPadding: EdgeInsets.all(2.0),
        content: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            height: 300,
            width: 300,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.1,
                    child: Icon(
                      Icons.check_circle_outline,
                      size: 300,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Order\nReceived',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.brown,
                          height: 0.9,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Thank You',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.brown,
                          fontFamily: 'HinaMincho',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Click anywhere to exit the menu'),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
