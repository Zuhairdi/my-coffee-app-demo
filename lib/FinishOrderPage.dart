import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:my_coffee_app/AnimationNumber.dart';
import 'package:my_coffee_app/CoffeeList.dart';
import 'package:my_coffee_app/SuccessDialog.dart';

class FinishOrderPage extends StatefulWidget {
  final List<Information> cartList;
  final VoidCallback onTransactionComplete;
  final Function(Information) onRemoveCart;
  const FinishOrderPage({
    Key? key,
    required this.cartList,
    required this.onTransactionComplete,
    required this.onRemoveCart,
  }) : super(key: key);
  @override
  _FinishOrderPageState createState() => _FinishOrderPageState();
}

class _FinishOrderPageState extends State<FinishOrderPage> {
  double totalPrice = 0.0;
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'en_US');
  Set<Information> mSet = {};
  Map<Information, int> mGroup = {};

  @override
  void initState() {
    super.initState();
    for (Information data in widget.cartList) {
      totalPrice = totalPrice + data.price;
      if (mSet.add(data))
        mGroup[data] = 1;
      else
        mGroup[data] = mGroup[data]! + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                'assets/panel-bg.jpg',
                fit: BoxFit.fitHeight,
                height: MediaQuery.of(context).size.height,
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            toolbarHeight: MediaQuery.of(context).size.height / 8,
            leading: SizedBox(),
            leadingWidth: 1.0,
            title: ListTile(
              title: Hero(
                tag: 'pay',
                child: Material(
                  color: Colors.transparent,
                  child: CountUp(
                    duration: Duration(milliseconds: 1000),
                    precision: 2,
                    locale: Locale('en_US'),
                    end: totalPrice,
                    prefix: '\$',
                    begin: 0,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              subtitle: Text('Total Price'),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              padding: const EdgeInsets.only(bottom: 100),
              children: mGroup.entries
                  .map<Widget>(
                    (e) => Dismissible(
                      dragStartBehavior: DragStartBehavior.start,
                      onDismissed: (direction) async {
                        totalPrice = 0;
                        if (e.value > 1) {
                          mGroup[e.key] = mGroup[e.key]! - 1;
                        } else {
                          mGroup.remove(e.key);
                        }
                        mGroup.forEach((key, value) {
                          totalPrice = totalPrice + (key.price * value);
                        });
                        setState(() {});
                        widget.onRemoveCart(e.key);
                        if (mGroup.isEmpty) {
                          await Future.delayed(Duration(milliseconds: 500));
                          Navigator.pop(context);
                        }
                      },
                      key: UniqueKey(),
                      child: Card(
                        color: Colors.brown.withOpacity(0.3),
                        shadowColor: Colors.transparent,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10),
                          minLeadingWidth: 1.0,
                          title: Text(e.key.itemName),
                          subtitle: Text(
                              '${formatCurrency.format(e.key.price * e.value)}'),
                          leading: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  '${e.value}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          floatingActionButton: mGroup.length > 0
              ? ConfirmButton(
                  onComplete: () {
                    widget.onTransactionComplete();
                  },
                )
              : SizedBox(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ],
    );
  }
}

class ConfirmButton extends StatefulWidget {
  final VoidCallback onComplete;
  const ConfirmButton({
    Key? key,
    required this.onComplete,
  }) : super(key: key);

  @override
  _ConfirmButtonState createState() => _ConfirmButtonState();
}

class _ConfirmButtonState extends State<ConfirmButton> {
  TextStyle _style = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    letterSpacing: 2.0,
  );
  Widget letter(String letter, int index) => BounceInDown(
        animate: true,
        duration: Duration(seconds: 1),
        controller: (ctrl) {
          _controller.add(ctrl);
        },
        child: Text(
          letter,
          style: _style,
        ),
      );
  List<AnimationController> _controller = [];
  List<String> mLetter = ['C', 'o', 'n', 'f', 'i', 'r', 'm'];

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        for (AnimationController c in _controller) {
          c.reverse(from: 1.0);
          await Future.delayed(Duration(milliseconds: 200));
        }
        await Future.delayed(Duration(milliseconds: 500));
        widget.onComplete();
        showSuccessDialog(context).then((value) => Navigator.pop(context));
      },
      child: Card(
        color: Color(0xFF935D2A),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 35.0,
            vertical: 15,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                mLetter.map((e) => letter(e, mLetter.indexOf(e))).toList(),
          ),
        ),
      ),
    );
  }
}
