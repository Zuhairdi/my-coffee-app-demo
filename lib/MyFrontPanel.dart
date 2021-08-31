import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_coffee_app/FrontPanelProvider.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MyFrontPanel extends StatelessWidget {
  const MyFrontPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FrontPanelProvider>(
      builder: (_, value, ___) => value.frontPanelOpacity == 0
          ? SizedBox()
          : Opacity(
              opacity: value.frontPanelOpacity,
              child: SlidingUpPanel(
                controller: value.controller,
                isDraggable: value.allowScroll,
                slideDirection: SlideDirection.DOWN,
                maxHeight: MediaQuery.of(context).size.height,
                defaultPanelState: PanelState.OPEN,
                onPanelClosed: () => value.allowScroll = false,
                onPanelSlide: (position) {
                  value.frontPanelOpacity = position;
                  if (position < 0.8)
                    value.dineInText = 'Welcome :)';
                  else
                    value.dineInText = 'Slide up to dine in';
                },
                panel: Stack(
                  children: [
                    Opacity(
                      opacity: 0.6,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Image.asset(
                          'assets/panel-bg.jpg',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Welcome to',
                              style: TextStyle(
                                fontSize: 30,
                                height: 1.0,
                              ),
                            ),
                            Text(
                              'Eureka\nCafe',
                              style: TextStyle(
                                fontSize: 80,
                                fontFamily: 'HinaMincho',
                                height: 1.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: double.infinity,
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [
                                0.4,
                                0.9
                              ],
                              colors: [
                                Color(0xFFF1AF78).withOpacity(0.4),
                                Colors.transparent
                              ]),
                        ),
                        child: Bounce(
                          infinite: true,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              value.dineInText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                height: 0.9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                body: SizedBox(),
              ),
            ),
    );
  }
}
