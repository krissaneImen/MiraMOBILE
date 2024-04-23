import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:mira/Provider/user_model.dart';
import 'package:mira/Screens/MenuScreens/NouveautesPage.dart';
import 'package:mira/Screens/MenuScreens/ReglementLoiCirculairePage.dart';
import 'package:mira/Screens/MenuScreens/ReglementExamensPage.dart';
import 'package:mira/Screens/MenuScreens/ReglementsPage.dart';
import 'package:mira/Screens/AuthScreens/login.dart';
import 'package:mira/Screens/MenuScreens/formations.dart';

class EnseignantDrawer extends StatelessWidget {
  final UserModel userModel; // Ajoutez une instance de UserModel comme argument

  EnseignantDrawer({required this.userModel});
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
              ),
            ),
            child: Text(
              'Menu Enseignant',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Outfit',
                    color: const Color.fromARGB(255, 100, 100, 100),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          ExpansionTile(
            leading: Icon(Icons.new_releases),
            title: Text(
              'Nouveautés',
              style: TextStyle(
                color: Color(0xFF15161E),
                fontSize: 16,
                fontFamily: 'Outfit',
              ),
            ),
            children: [
              ListTile(
                title: Text(
                  'Actualités',
                  style: TextStyle(
                    color: Color(0xFF15161E),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => NouveautesPage(
                            userModel: userModel,
                          )));
                },
              ),
              ListTile(
                title: Text(
                  'Formations',
                  style: TextStyle(
                    color: Color(0xFF15161E),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => FormationList()));
                },
              ),
              ListTile(
                title: Text(
                  'Manifestations',
                  style: TextStyle(
                    color: Color(0xFF15161E),
                  ),
                ),
                onTap: () {
                  // Mettez ici le code que vous souhaitez exécuter
                },
              ),
              ListTile(
                title: Text(
                  'Calendriers des Examens',
                  style: TextStyle(
                    color: Color(0xFF15161E),
                  ),
                ),
                onTap: () {
                  // Mettez ici le code que vous souhaitez exécuter
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: Icon(Icons.business),
            title: Text(
              'Services Enseignants',
              style: TextStyle(
                color: Color(0xFF15161E),
                fontSize: 16,
                fontFamily: 'Outfit',
              ),
            ),
            children: [
              ListTile(
                title: Text(
                  'Photocopies',
                  style: TextStyle(
                    color: Color(0xFF15161E),
                  ),
                ),
                onTap: () {
                  // Mettez ici le code que vous souhaitez exécuter
                },
              ),
              ListTile(
                title: Text(
                  'Emplois du Temps',
                  style: TextStyle(
                    color: Color(0xFF15161E),
                  ),
                ),
                onTap: () {
                  // Mettez ici le code que vous souhaitez exécuter
                },
              ),
              ListTile(
                title: Text(
                  'Calendrier des surveillances',
                  style: TextStyle(
                    color: Color(0xFF15161E),
                  ),
                ),
                onTap: () {
                  // Mettez ici le code que vous souhaitez exécuter
                },
              ),
              ListTile(
                title: Text(
                  'Attectation de travail',
                  style: TextStyle(
                    color: Color(0xFF15161E),
                  ),
                ),
                onTap: () {
                  // Mettez ici le code que vous souhaitez exécuter
                },
              ),
              ListTile(
                title: Text(
                  'Avis d absence',
                  style: TextStyle(
                    color: Color(0xFF15161E),
                  ),
                ),
                onTap: () {
                  // Mettez ici le code que vous souhaitez exécuter
                },
              ),
              ListTile(
                title: Text(
                  'Avis de Test',
                  style: TextStyle(
                    color: Color(0xFF15161E),
                  ),
                ),
                onTap: () {
                  // Mettez ici le code que vous souhaitez exécuter
                },
              ),
              ListTile(
                title: Text(
                  'Absences collectives',
                  style: TextStyle(
                    color: Color(0xFF15161E),
                  ),
                ),
                onTap: () {
                  // Mettez ici le code que vous souhaitez exécuter
                },
              ),
              ListTile(
                title: Text(
                  'Autorisations de formation',
                  style: TextStyle(
                    color: Color(0xFF15161E),
                  ),
                ),
                onTap: () {
                  // Mettez ici le code que vous souhaitez exécuter
                },
              ),
              ListTile(
                title: Text(
                  'Conseils scientifiques',
                  style: TextStyle(
                    color: Color(0xFF15161E),
                  ),
                ),
                onTap: () {
                  // Mettez ici le code que vous souhaitez exécuter
                },
              ),
              ListTile(
                title: Text(
                  'Réunions des directeurs',
                  style: TextStyle(
                    color: Color(0xFF15161E),
                  ),
                ),
                onTap: () {
                  // Mettez ici le code que vous souhaitez exécuter
                },
              ),
              ListTile(
                title: Text(
                  'Réservations de ressources',
                  style: TextStyle(
                    color: Color(0xFF15161E),
                  ),
                ),
                onTap: () {
                  // Mettez ici le code que vous souhaitez exécuter
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.playlist_add_check),
            title: Text(
              'Fiches de présence',
              style: TextStyle(
                color: Color(0xFF15161E),
                fontSize: 16,
              ),
            ),
          ),
          ExpansionTile(
            leading: Icon(Icons.library_books),
            title: Text(
              'Documentations',
              style: TextStyle(
                color: Color(0xFF15161E),
                fontSize: 16,
                fontFamily: 'Outfit',
              ),
            ),
            children: [
              ListTile(
                title: Text(
                  'Règlement Intérieur',
                  style: TextStyle(
                    color: Color(0xFF15161E),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ReglementsPage()));
                },
              ),
              ListTile(
                title: Text(
                  'Règlement des examens',
                  style: TextStyle(
                    color: Color(0xFF15161E),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ReglementExamensPage(
                            userModel: userModel,
                          )));
                },
              ),
              ListTile(
                title: Text(
                  'Documents',
                  style: TextStyle(
                    color: Color(0xFF15161E),
                  ),
                ),
                onTap: () {
                  // Mettez ici le code que vous souhaitez exécuter
                },
              ),
              ListTile(
                title: Text(
                  'Lois et Circulaires',
                  style: TextStyle(
                    color: Color(0xFF15161E),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ReglementLoiCirculairePage(
                        userModel: userModel,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Identité visuelle',
                  style: TextStyle(
                    color: Color(0xFF15161E),
                  ),
                ),
                onTap: () {
                  // Mettez ici le code que vous souhaitez exécuter
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: Icon(Icons.library_books),
            title: Text(
              'Médiathèque',
              style: TextStyle(
                color: Color(0xFF15161E),
                fontSize: 16,
                fontFamily: 'Outfit',
              ),
            ),
            children: [
              ListTile(
                title: Text(
                  'Supports de cours',
                  style: TextStyle(
                    color: Color(0xFF15161E),
                  ),
                ),
                onTap: () {
                  // Mettez ici le code que vous souhaitez exécuter
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(
              'Déconnexion',
              style: TextStyle(
                color: Color(0xFF15161E),
                fontSize: 16,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
