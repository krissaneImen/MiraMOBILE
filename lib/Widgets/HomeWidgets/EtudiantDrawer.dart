import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mira/Provider/user_model.dart';
import 'package:mira/Screens/MenuScreens/Actualit%C3%A9%20et%20docuements%20admin/Calendriers.dart';
import 'package:mira/Screens/MenuScreens/ActualityPage.dart';
import 'package:mira/Screens/MenuScreens/Reglements/TypesReglements.dart';
import 'package:mira/Screens/MenuScreens/Services.dart';
import 'package:mira/Screens/MenuScreens/Stages/Stages.dart';
import 'package:mira/Screens/MenuScreens/formations.dart';

class EtudiantDrawer extends StatefulWidget {
  final UserModel userModel;

  EtudiantDrawer({required this.userModel}) {}

  @override
  _EtudiantDrawerState createState() => _EtudiantDrawerState();
}

class _EtudiantDrawerState extends State<EtudiantDrawer> {
  bool _isDrawerOpen = false;
  @override
  void initState() {
    super.initState();
    widget.userModel.getProfileImage();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isDrawerOpen = !_isDrawerOpen;
          });
        },
        child: AnimatedContainer(
          width: _isDrawerOpen ? 270 : 0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(0),
            boxShadow: _isDrawerOpen
                ? [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x33000000),
                      offset: Offset(
                        0,
                        2,
                      ),
                    )
                  ]
                : [],
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 24),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.university,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 32,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Text(
                            'Iset Tataouine',
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  fontFamily: 'Outfit',
                                  letterSpacing: 0,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActualiteWidget(
                            userModel: widget.userModel,
                          ),
                        ),
                      );
                    },
                    child: buildMenuOption(
                      icon: Icons.new_releases,
                      text: 'Actualités',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormationList(
                            userModel: widget.userModel,
                          ),
                        ),
                      );
                    },
                    child: buildMenuOption(
                      icon: Icons.school,
                      text: 'Formations',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CalendriersWidget(
                            userModel: widget.userModel,
                          ),
                        ),
                      );
                    },
                    child: buildMenuOption(
                      icon: Icons.calendar_month_sharp,
                      text: 'Calendriers',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Services(
                            userModel: widget.userModel,
                          ),
                        ),
                      );
                    },
                    child: buildMenuOption(
                      icon: Icons.miscellaneous_services,
                      text: 'Services et Demandes',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TypesReglement(
                            userModel: widget.userModel,
                          ),
                        ),
                      );
                    },
                    child: buildMenuOption(
                      icon: Icons.library_books,
                      text: 'Règlements',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Stages(
                            userModel: widget.userModel,
                          ),
                        ),
                      );
                    },
                    child: buildMenuOption(
                      icon: Icons.work,
                      text: 'Stages et Rapport',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.userModel.clearSession(
                          context); // Appeler clearSession lorsque l'utilisateur appuie sur l'option de déconnexion
                    },
                    child: buildMenuOption(
                      icon: Icons.logout,
                      text: 'Déconnexion',
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Divider(
                            height: 12,
                            thickness: 2,
                            color: FlutterFlowTheme.of(context).alternate,
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).accent1,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 2,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(2),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: FutureBuilder<void>(
                                        future:
                                            widget.userModel.getProfileImage(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            // While waiting for the image to load, display a placeholder or loading indicator
                                            return Placeholder(
                                              fallbackHeight: 44,
                                              fallbackWidth: 44,
                                            );
                                          } else if (snapshot.hasError) {
                                            // If there's an error loading the image, display an error message
                                            return Text(
                                                'Error loading profile image');
                                          } else {
                                            // If image is loaded successfully, display the image
                                            return Image(
                                              image: widget
                                                  .userModel.profileImage.image,
                                              width: 44,
                                              height: 44,
                                              fit: BoxFit.cover,
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.userModel.firstName,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                letterSpacing: 0,
                                              ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 4, 0, 0),
                                          child: Text(
                                            widget.userModel.email,
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  letterSpacing: 0,
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenuOption({
    required IconData icon,
    required String text,
  }) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
      child: Container(
        width: double.infinity,
        height: 50,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 12, 12),
                child: Container(
                  width: 4,
                  height: 100,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              Icon(
                icon,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 28,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                child: Text(
                  text,
                  style: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Readex Pro',
                        color: FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
