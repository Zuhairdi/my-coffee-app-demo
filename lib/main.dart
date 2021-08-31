import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_coffee_app/CartProvider.dart';
import 'package:my_coffee_app/FrontPanelProvider.dart';
import 'package:my_coffee_app/MainProvider.dart';
import 'package:my_coffee_app/MyHomePage.dart';
import 'package:my_coffee_app/MyMaterialColor.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Coffee App',
      theme: ThemeData(
        primarySwatch: myColor(),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Color(0xFFD4792F)),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider<MainProvider>(
                    create: (context) => MainProvider()),
                ChangeNotifierProvider<CartProvider>(
                    create: (context) => CartProvider()),
                ChangeNotifierProvider<FrontPanelProvider>(
                    create: (context) => FrontPanelProvider()),
              ],
              child: MyHomePage(),
            ),
      },
    );
  }
}
