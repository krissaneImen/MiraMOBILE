import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:mira/Provider/user_model.dart';
import 'package:mira/Screens/MenuScreens/NouveautesPage.dart';
import 'package:mira/Screens/Profil.dart';
import 'package:mira/Widgets/LoginWidgets/AdministratifDrawer.dart';
import 'package:mira/Widgets/LoginWidgets/EnseignantDrawer.dart';
import 'package:mira/Widgets/LoginWidgets/EtudiantDrawer.dart';

class Accueil extends StatefulWidget {
  final UserModel userModel;

  const Accueil({Key? key, required this.userModel}) : super(key: key);

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget drawerWidget;
    switch (widget.userModel.statut) {
      case 'Enseignant':
        drawerWidget = EnseignantDrawer(
          userModel: widget.userModel,
        );
        break;
      case 'Administratif':
        drawerWidget = AdministratifDrawer(
          userModel: widget.userModel,
        );
        break;
      case 'Etudiant':
        drawerWidget = EtudiantDrawer();
        break;
      default:
        drawerWidget = Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Mettez ici le code que vous souhaitez exécuter lorsque l'élément 1 est sélectionné dans la barre de navigation latérale
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Mettez ici le code que vous souhaitez exécuter lorsque l'élément 2 est sélectionné dans la barre de navigation latérale
                },
              ),
            ],
          ),
        );
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Iset Tataouine'),
        automaticallyImplyLeading: false,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        leading: Builder(
          builder: (context) => FlutterFlowIconButton(
            borderRadius: 30,
            buttonSize: 60,
            icon: Icon(
              Icons.menu_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: drawerWidget,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 16, 0, 12),
              child: Text(
                'Accueil',
                style: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Readex Pro',
                      letterSpacing: 0,
                    ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NouveautesPage(
                            userModel: widget.userModel,
                          )),
                );
              },
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        'assets/act.jpeg',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Toutes l\'actualité',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Naviguer vers la page des manifestations
              },
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        'assets/man.jpeg',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Toutes les manifestations',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: FlutterFlowTheme.of(context).primary,
        unselectedItemColor: FlutterFlowTheme.of(context).secondaryText,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Acceuil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_rounded),
            label: 'Cours',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note_rounded),
            label: 'Evenements',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.keyboard_control_rounded),
            label: 'Voir plus',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Naviguer vers la page d'accueil
        // Ajoutez la logique de navigation appropriée ici
        break;
      case 1:
        // Naviguer vers la page des cours
        // Ajoutez la logique de navigation appropriée ici
        break;
      case 2:
        // Naviguer vers la page des événements
        // Ajoutez la logique de navigation appropriée ici
        break;
      case 3:
        // Naviguer vers la page de profil
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Profile()), // Remplacez ProfilePage par le nom de votre page de profil
        );
        break;
      case 4:
        // Naviguer vers la page "Voir plus"
        // Ajoutez la logique de navigation appropriée ici
        break;
      default:
        break;
    }
  }
}
