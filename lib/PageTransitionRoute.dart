import 'package:flutter/cupertino.dart';

class PageTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  PageTransitionRoute(this.widget)
      : super(
          transitionDuration: Duration(milliseconds: 1000),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curveAnimation =
                CurvedAnimation(parent: animation, curve: Curves.bounceIn);
            return FadeTransition(
              opacity: curveAnimation,
              child: child,
            );
          },
          pageBuilder: (context, animation, secondaryAnimation) {
            return widget;
          },
        );
}
