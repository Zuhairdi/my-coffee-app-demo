import 'package:flutter/material.dart';
import 'package:my_coffee_app/CoffeeList.dart';

class MainProvider extends ChangeNotifier {
  int _currentSelection = 0;
  String _itemSize = 'Medium';
  double _itemPrice = coffeeName.last.price;
  double _panelOpacity = 0;

  double get itemPrice => _itemPrice;

  double get panelOpacity => _panelOpacity;

  set panelOpacity(double value) {
    _panelOpacity = value;
    notifyListeners();
  }

  set itemPrice(double value) {
    _itemPrice = value;
    notifyListeners();
  }

  resetPrice(int i) {
    itemPrice = coffeeName[i].price;
  }

  int get currentSelection => _currentSelection;

  set currentSelection(int value) {
    _currentSelection = value;
    notifyListeners();
  }

  String get itemSize => _itemSize;

  set itemSize(String value) {
    _itemSize = value;
    notifyListeners();
  }

  void updatePrice(double scale) {
    if (scale < 0.7) {
      itemSize = 'Small';
    } else if (scale > 1.3) {
      itemSize = 'Medium';
    } else {
      itemSize = 'Large';
    }
  }

  // AnimationController get controller1 => _controller1;
  //
  // set controller1(AnimationController value) {
  //   _controller1 = value;
  //   notifyListeners();
  // }
  //
  // AnimationController get controller2 => _controller2;
  //
  // set controller2(AnimationController value) {
  //   _controller2 = value;
  //   notifyListeners();
  // }
  //
  // AnimationController get controller3 => _controller3;
  //
  // set controller3(AnimationController value) {
  //   _controller3 = value;
  //   notifyListeners();
  // }
  //
  // AnimationController get controller4 => _controller4;
  //
  // set controller4(AnimationController value) {
  //   _controller4 = value;
  //   notifyListeners();
  // }
}
