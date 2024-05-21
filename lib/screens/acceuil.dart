import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:mira/Provider/user_model.dart';
import 'package:mira/Screens/MenuScreens/Cours.dart';
import 'package:mira/Screens/MenuScreens/ActualityPage.dart';
import 'package:mira/Screens/Profil.dart';
import 'package:mira/Widgets/HomeWidgets/UserDrawer.dart';

class Accueil extends StatefulWidget {
  final UserModel userModel;

  const Accueil({Key? key, required this.userModel}) : super(key: key);

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  int _selectedIndex = 0;
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    Widget drawerWidget = UserDrawer(userModel: widget.userModel);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Iset Tataouine'),
        automaticallyImplyLeading: false,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        leading: FlutterFlowIconButton(
          borderRadius: 30,
          buttonSize: 60,
          icon: Icon(
            Icons.menu_rounded,
            color: FlutterFlowTheme.of(context).primaryText,
            size: 30,
          ),
          onPressed:
              _onMenuButtonPressed, // Appel de la fonction pour ouvrir le tiroir utilisateur
        ),
      ),
      drawer: drawerWidget,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contenu de la page
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
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_rounded),
            label: 'Cours',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note_rounded),
            label: 'Actualités',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profil',
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
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CoursWidget(
              userModel: widget.userModel,
            ),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ActualiteWidget(
              userModel: widget.userModel,
            ),
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profile(
              firstName: widget.userModel.firstName,
              lastName: widget.userModel.lastName,
              statut: widget.userModel.statut,
              cin: widget.userModel.cin,
            ),
          ),
        );
        break;
      default:
        break;
    }
  }

  void _onMenuButtonPressed() {
    _scaffoldKey.currentState?.openDrawer();
  }
}
