import 'package:flutter/cupertino.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class FrontPanelProvider extends ChangeNotifier {
  double _frontPanelOpacity = 1.0;
  bool _allowScroll = true;
  PanelController _controller = PanelController();

  resetFrontPanel() {
    frontPanelOpacity = 1.0;
    allowScroll = true;
    dineInText = 'Slide up to dine in';
  }

  PanelController get controller => _controller;

  set controller(PanelController value) {
    _controller = value;
    notifyListeners();
  }

  String _dineInText = 'Slide up to dine in';

  String get dineInText => _dineInText;

  set dineInText(String value) {
    _dineInText = value;
    notifyListeners();
  }

  bool get allowScroll => _allowScroll;

  set allowScroll(bool value) {
    _allowScroll = value;
    notifyListeners();
  }

  double get frontPanelOpacity => _frontPanelOpacity;

  set frontPanelOpacity(double value) {
    _frontPanelOpacity = value;
    notifyListeners();
  }
}
