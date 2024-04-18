import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mira/Screens/AuthScreens/login.dart';
import 'package:google_fonts/google_fonts.dart'; // Importez la bibliothèque google_fonts

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Démarrez l'animation de fondu
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
    // Attendre 3 secondes puis naviguer vers la page principale
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (_) =>
                LoginPage()), // Remplacez HomeScreen par la page principale de votre application
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              duration: Duration(milliseconds: 1000),
              opacity: _opacity,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 241, 180, 25)),
              ),
            ),
            SizedBox(
                height:
                    40), // Espacement entre le cercle de chargement et le titre
            AnimatedOpacity(
              duration: Duration(milliseconds: 1000),
              opacity: _opacity,
              child: Text(
                'Iset Tataouine',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 121, 121, 121),
                  fontFamily: 'Readex Pro',
                ),
              ),
            ),
            SizedBox(
                height: 40), // Espacement entre le titre et la rangée d'icônes
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Ajoutez des icônes ici si nécessaire
              ],
            ),
            SizedBox(
                height:
                    250), // Espacement entre la rangée d'icônes et le texte "Par Mira"
            Text(
              'By Mira',
              style: GoogleFonts.dancingScript(
                // Utilisation de GoogleFonts.dancingScript
                textStyle: TextStyle(
                  fontSize: 35,
                  color: Colors.black54,
                  fontStyle: FontStyle
                      .italic, // Ajout de la propriété fontStyle pour inclure l'italique
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
