import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_coffee_app/CartProvider.dart';
import 'package:my_coffee_app/CoffeeList.dart';
import 'package:my_coffee_app/MainProvider.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MyCart extends StatelessWidget {
  final Function(AnimationController)? cartAnimController;

  const MyCart({Key? key, required this.cartAnimController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeftBig(
      duration: Duration(milliseconds: 300),
      animate: false,
      manualTrigger: true,
      controller: cartAnimController,
      child: Card(
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        child: Container(
          height: 60,
          child: Consumer<CartProvider>(
            builder: (_, value, __) => ListView.builder(
              controller: value.cartController,
              shrinkWrap: false,
              scrollDirection: Axis.horizontal,
              itemCount: value.cart.length,
              itemBuilder: (context, index) {
                Information data = value.cart[index];
                return BounceInUp(
                  duration: Duration(milliseconds: 500),
                  child: Dismissible(
                    onDismissed: (direction) => value.removeFromCart(index),
                    direction: DismissDirection.vertical,
                    key: UniqueKey(),
                    child: Card(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          data.asset,
                          height: 20,
                          width: 50,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class AddItemButton extends StatefulWidget {
  const AddItemButton({
    Key? key,
    required this.addOn,
  }) : super(key: key);

  final bool addOn;

  @override
  _AddItemButtonState createState() => _AddItemButtonState();
}

class _AddItemButtonState extends State<AddItemButton> {
  Widget buttonContent = Icon(Icons.add);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (_, value, __) => FloatingActionButton(
        heroTag: 'addItem',
        onPressed: () async {
          setState(() {
            buttonContent = Spin(
              duration: Duration(milliseconds: 300),
              child: Icon(Icons.autorenew),
            );
          });
          await Future.delayed(Duration(milliseconds: 300));
          buttonContent = Icon(Icons.add);
          if (!widget.addOn) {
            //make the coffee jump
            AnimationController ctrl = value.animController[value.itemIndex];
            ctrl.forward(from: 0.0);
          }
          value.addToCart(value.selection);
          await Future.delayed(const Duration(milliseconds: 300));
          SchedulerBinding.instance?.addPostFrameCallback((_) {
            value.cartController.animateTo(
                value.cartController.position.maxScrollExtent,
                duration: Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn);
          });
        },
        child: buttonContent,
      ),
    );
  }
}

class CartBackground extends StatelessWidget {
  final VoidCallback onPanelClosed;
  final VoidCallback onPanelOpened;
  final PanelController controller3;

  const CartBackground({
    Key? key,
    required this.controller3,
    required this.onPanelClosed,
    required this.onPanelOpened,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (_, value, __) => SlidingUpPanel(
        isDraggable: false,
        onPanelOpened: () => onPanelOpened(),
        onPanelClosed: () => onPanelClosed(),
        color: Colors.transparent,
        maxHeight: 590,
        controller: controller3,
        collapsed: SizedBox(),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15.0),
          topLeft: Radius.circular(15.0),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 1.0,
            color: Colors.black.withOpacity(value.panelOpacity),
          )
        ],
        onPanelSlide: (position) {
          value.panelOpacity = position / 5;
        },
        panel: Container(),
      ),
    );
  }
}
