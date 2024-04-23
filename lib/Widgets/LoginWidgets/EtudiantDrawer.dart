import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:mira/Screens/AuthScreens/login.dart';

class EtudiantDrawer extends StatefulWidget {
  @override
  _EtudiantDrawerState createState() => _EtudiantDrawerState();
}

class _EtudiantDrawerState extends State<EtudiantDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  FlutterFlowTheme.of(context).primaryBackground,
                  FlutterFlowTheme.of(context).primaryBackground
                ],
              ), // Fermez correctement la définition du gradient
            ),
            child: Text(
              'Menu Étudiant',
              style: TextStyle(
                color: const Color.fromARGB(255, 100, 100, 100),
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Item Étudiant 1'),
            onTap: () {
              // Mettez ici le code que vous souhaitez exécuter lorsque l'élément 1 est sélectionné dans le menu latéral de l'étudiant
            },
          ),
          ListTile(
            title: Text('Item Étudiant 2'),
            onTap: () {
              // Mettez ici le code que vous souhaitez exécuter lorsque l'élément 2 est sélectionné dans le menu latéral de l'étudiant
            },
          ),
          ListTile(
            title: Text('Déconnexion'),
            onTap: () {
              // Code pour gérer la déconnexion de l'utilisateur
              // Par exemple, vous pouvez appeler une fonction pour vider les données utilisateur et rediriger vers la page de connexion
              // Par exemple, si vous utilisez une classe UserModel, vous pouvez appeler la méthode de déconnexion ainsi :
              // userModel.logout();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
