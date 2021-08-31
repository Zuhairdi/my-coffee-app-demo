import 'package:flutter/cupertino.dart';
import 'package:my_coffee_app/CoffeeList.dart';

class CartProvider extends ChangeNotifier {
  List<Information> _cart = [];
  bool _payNowState = false;
  int? _itemIndex = coffeeName.length - 1;

  int coffeeIndex = coffeeName.length - 1;

  Information _selection = coffeeName.last;
  ScrollController _cartController = ScrollController();
  List<AnimationController> _animController = [];

  int get itemIndex => _itemIndex!;

  set itemIndex(int value) {
    _itemIndex = value;
    coffeeIndex = value;
    notifyListeners();
  }

  closeAddOn() {
    itemIndex = coffeeIndex;
    selection = coffeeName[itemIndex];
  }

  List<AnimationController> get animController => _animController;

  set animController(List<AnimationController> value) {
    _animController = value;
    notifyListeners();
  }

  addToAnimationController(AnimationController controller) {
    animController.add(controller);
  }

  ScrollController get cartController => _cartController;

  set cartController(ScrollController value) {
    _cartController = value;
    notifyListeners();
  }

  bool get payNowState => _payNowState;

  set payNowState(bool value) {
    _payNowState = value;
    notifyListeners();
  }

  switchPayNowButton() {
    if (cart.isEmpty) {
      payNowState = false;
      return;
    }
    payNowState = !payNowState;
  }

  List<Information> get cart => _cart;
  set cart(List<Information> value) {
    _cart = value;
    notifyListeners();
  }

  addToCart(Information data) {
    cart.add(data);
    notifyListeners();
  }

  cartClear() {
    cart.clear();
    notifyListeners();
  }

  removeFromCart(int i) {
    cart.removeAt(i);
    notifyListeners();
  }

  Information get selection => _selection;

  set selection(Information value) {
    _selection = value;
    notifyListeners();
  }
}
