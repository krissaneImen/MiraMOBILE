import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mira/Provider/user_model.dart';
import 'package:mira/Screens/MenuScreens/ActualityPage.dart';
import 'package:mira/Screens/MenuScreens/Reglements/TypesReglements.dart';
import 'package:mira/Screens/MenuScreens/Services.dart';
import 'package:mira/Screens/MenuScreens/Stages/Stages.dart';
import 'package:mira/Screens/MenuScreens/formations.dart';

class EnseignantDrawer extends StatefulWidget {
  final UserModel userModel;

  EnseignantDrawer({required this.userModel});

  @override
  _EnseignantDrawerState createState() => _EnseignantDrawerState();
}

class _EnseignantDrawerState extends State<EnseignantDrawer> {
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
          decoration: _buildDrawerDecoration(context),
          child: _buildDrawerContent(context),
        ),
      ),
    );
  }

  BoxDecoration _buildDrawerDecoration(BuildContext context) {
    return BoxDecoration(
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
    );
  }

  Widget _buildDrawerContent(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDrawerHeader(context),
            _buildMenuOption(
              icon: Icons.new_releases,
              text: 'Actualités',
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
            ),
            _buildMenuOption(
              icon: Icons.school,
              text: 'Formations',
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
            ),
            _buildMenuOption(
              icon: Icons.new_releases,
              text: 'Calendriers',
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
            ),
            _buildMenuOption(
              icon: Icons.new_releases,
              text: 'Services et Demandes',
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
            ),
            _buildMenuOption(
              icon: Icons.new_releases,
              text: 'Règlements',
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
            ),
            _buildMenuOption(
              icon: Icons.new_releases,
              text: 'Stages et Rapport',
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
            ),
            _buildMenuOption(
              icon: Icons.logout,
              text: 'Déconnexion',
              onTap: () {
                widget.userModel.clearSession(
                    context); // Appeler clearSession lorsque l'utilisateur appuie sur l'option de déconnexion
              },
            ),
            // Ajoutez d'autres options de menu ici...
            _buildDrawerFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return Padding(
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
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Outfit',
                    letterSpacing: 0,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuOption({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
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
      ),
    );
  }

  Widget _buildDrawerFooter(BuildContext context) {
    return Expanded(
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
              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
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
                        color: FlutterFlowTheme.of(context).primary,
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: FutureBuilder<void>(
                          future: widget.userModel.getProfileImage(),
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
                              return Text('Error loading profile image');
                            } else {
                              // If image is loaded successfully, display the image
                              return Image(
                                image: widget.userModel.profileImage.image,
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
                      padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.userModel.firstName,
                            style:
                                FlutterFlowTheme.of(context).bodyLarge.override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0,
                                    ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
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
    );
  }
}
