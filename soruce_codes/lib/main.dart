import 'package:flutter/material.dart';
import 'package:getitdone/models/items_data.dart';
import 'package:getitdone/screens/homepage.dart';
import 'package:provider/provider.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';

import 'models/color_models_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ColorThemeData().createPrefObject();
  await ItemsData().createPrefObject();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ItemsData>(create: (context) => ItemsData()),
    ChangeNotifierProvider<ColorThemeData>(
        create: (context) => ColorThemeData())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Provider.of<ColorThemeData>(context).loadThemeFromSharedPref();
    Provider.of<ItemsData>(context).loadItemsFromSharedPref();
    return MaterialApp(
      title: 'Get It Done',
      theme: Provider.of<ColorThemeData>(context).selectedThemeData,
      home: const SplashScreenPage(),
    );
  }
}

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];
    return SplashScreenView(
      navigateRoute: const HomePage(),
      duration: Duration(seconds: 1),
      text: ColorizeAnimatedText(
        "Get It Done",
        speed: const Duration(seconds: 1),
        colors: colorizeColors,
        textStyle: const TextStyle(
          fontFamily: 'LeagueGothic',
          fontSize: 50.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      imageSrc: "assets/splashscreenicon.png",
      // paddingText
      // paddingLoading
    );
  }
}
