import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_coffee_app/AddOnList.dart';
import 'package:my_coffee_app/AnimationNumber.dart';
import 'package:my_coffee_app/CarouselItem.dart';
import 'package:my_coffee_app/CartProvider.dart';
import 'package:my_coffee_app/CoffeeList.dart';
import 'package:my_coffee_app/CustomCarouselOptions.dart';
import 'package:my_coffee_app/CustomVerticalPager.dart';
import 'package:my_coffee_app/FinishOrderPage.dart';
import 'package:my_coffee_app/FrontPanelProvider.dart';
import 'package:my_coffee_app/MainProvider.dart';
import 'package:my_coffee_app/MyCart.dart';
import 'package:my_coffee_app/MyFrontPanel.dart';
import 'package:my_coffee_app/PageTransitionRoute.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PanelController? _panelController = PanelController();
  final int animationDelay = 100;
  final double currentPrice = 0.00;
  bool doubleTapClose = false;
  bool addOn = false;
  late Timer t;

  late AnimationController controller1; //add button
  late AnimationController controller2; //cart-line

  void openButton() async {
    await Future.delayed(Duration.zero);
    controller1.forward();
    await Future.delayed(Duration(milliseconds: animationDelay));
    controller2.forward();
  }

  void closeButton() async {
    await Future.delayed(Duration.zero);
    controller2.reverse();
    await Future.delayed(Duration(milliseconds: animationDelay));
    controller1.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var panel = Provider.of<FrontPanelProvider>(context);
        if (!panel.allowScroll) {
          panel.allowScroll = true;
          panel.frontPanelOpacity = 1.0;
          panel.dineInText = 'Slide up to dine in';
          return false;
        } else {
          if (!doubleTapClose) {
            doubleTapClose = true;
            panel.dineInText = 'Click again to close app';
            t = Timer.periodic(Duration(seconds: 2), (timer) {
              panel.dineInText = 'Slide up to dine in';
              timer.cancel();
              doubleTapClose = false;
            });
            return false;
          } else {
            if (t.isActive) t.cancel();
            return true;
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            //top box in the background
            Positioned(
              top: 20,
              left: 20,
              height: 130,
              width: 300,
              child: Card(),
            ),
            //middle box in the background
            Positioned(
              top: 150,
              left: 40,
              height: 300,
              width: 350,
              child: Card(),
            ),
            //bottom box in the background
            Positioned(
              top: 450,
              left: 60,
              height: 170,
              width: 310,
              child: Card(),
            ),
            //price tag
            Padding(
              padding: const EdgeInsets.only(
                top: 40.0,
                left: 40.0,
              ),
              child: ListTile(
                title: Consumer<MainProvider>(
                  builder: (_, value, __) => Hero(
                    tag: 'pay',
                    child: Material(
                      color: Colors.transparent,
                      shadowColor: Colors.transparent,
                      child: CountUp(
                        duration: Duration(milliseconds: 300),
                        precision: 2,
                        locale: Locale('en_US'),
                        end: value.itemPrice,
                        prefix: '\$',
                        begin: currentPrice,
                        style: TextStyle(
                          fontSize: 30,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ),
                subtitle: Consumer<MainProvider>(
                  builder: (_, value, __) => Text('${value.itemSize}'),
                ),
              ),
            ),
            //cart background
            CartBackground(
              onPanelClosed: () {
                closeButton();
                if (addOn) {
                  setState(() {
                    Provider.of<CartProvider>(context, listen: false)
                        .selection = coffeeName.last;
                    Provider.of<CartProvider>(context, listen: false)
                        .itemIndex = coffeeName.length - 1;
                    addOn = false;
                  });
                }
              },
              onPanelOpened: () => openButton(),
              controller3: _panelController!,
            ),
            //coffee list
            Opacity(
              opacity: addOn ? 0.00 : 1.00,
              child: AbsorbPointer(
                //absorb pointer will disable the widget
                absorbing: addOn,
                child: Container(
                  height: double.infinity,
                  child: Consumer<CartProvider>(
                    builder: (_, value, __) => CustomVerticalCardPager(
                      align: ALIGN.RIGHT,
                      initialPage: coffeeName.length - 1,
                      images: coffeeList(),
                      textStyle: TextStyle(color: Colors.transparent),
                      onSelectedItem: (index) async {
                        _panelController!.animatePanelToPosition(
                            _panelController!.isPanelClosed ? 1.0 : 0.0,
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.elasticInOut);
                        value.switchPayNowButton();
                      },
                      onPageChanged: (page) {
                        int? currentItem = page!.round();
                        if (value.itemIndex != currentItem) {
                          Provider.of<MainProvider>(context, listen: false)
                              .itemPrice = coffeeName[currentItem].price;
                          value.itemIndex = currentItem;
                          value.selection = coffeeName[value.itemIndex];
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            //desserts list
            addOn
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DessertAppBar(onReturnPressed: () {
                        var value =
                            Provider.of<CartProvider>(context, listen: false);
                        setState(() {
                          addOn = false;
                          value.closeAddOn();
                          Provider.of<MainProvider>(context, listen: false)
                              .resetPrice(value.coffeeIndex);
                        });
                      }),
                      CarouselSlider(
                        items: addOnName
                            .map((e) => CarouselItem(data: e))
                            .toList(),
                        options: MyCarouselOptions(context),
                      ),
                    ],
                  )
                : SizedBox(),
            //payment floating button
            Consumer<CartProvider>(
              builder: (_, value, __) => value.cart.isNotEmpty
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 120),
                        child: BounceInLeft(
                          duration: Duration(milliseconds: 500),
                          from: 0.0,
                          child: FloatingActionButton(
                            heroTag: 'pay_button',
                            onPressed: () {
                              setState(() {
                                if (!addOn) {
                                  value.selection = addOnName[0];
                                  Provider.of<MainProvider>(
                                    context,
                                    listen: false,
                                  ).itemPrice = addOnName[0].price;
                                } else {
                                  value.closeAddOn();
                                  Provider.of<MainProvider>(
                                    context,
                                    listen: false,
                                  ).itemPrice = coffeeName[0].price;
                                  Navigator.push(
                                    context,
                                    PageTransitionRoute(
                                      FinishOrderPage(
                                        cartList: value.cart,
                                        onTransactionComplete: () async {
                                          value.cartClear();
                                          _panelController!.close();
                                          Provider.of<FrontPanelProvider>(
                                            context,
                                            listen: false,
                                          ).resetFrontPanel();
                                        },
                                        onRemoveCart: (data) {
                                          int i = value.cart.indexOf(data);
                                          value.removeFromCart(i);
                                        },
                                      ),
                                    ),
                                  );
                                }
                                addOn = !addOn;
                              });
                            },
                            child: !addOn ? Text('done') : Text('pay'),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ),
            //cart list
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyCart(cartAnimController: (ctrl) => controller2 = ctrl),
                  SizedBox(height: 20),
                  BounceInRight(
                    duration: Duration(milliseconds: 200),
                    manualTrigger: true,
                    animate: false,
                    controller: (ctrl) => controller1 = ctrl,
                    child: AddItemButton(addOn: addOn),
                  ),
                  SizedBox(height: 25),
                ],
              ),
            ),
            //front panel welcome to Eureka Cafe
            MyFrontPanel(),
          ],
        ),
      ),
    );
  }
}
