import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mira/Constants/SplashScreen.dart';

void main() {
  runApp(MaterialApp(
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('fr', 'FR'),
      Locale('ar', 'AR'),
    ],
    debugShowCheckedModeBanner: false,
    home: SplashScreen(), // Passer l'instance de ClientModel
  ));
}
