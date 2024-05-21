import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:http/http.dart' as http;
import 'package:mira/Provider/user_model.dart';

class FormationsDetails extends StatefulWidget {
  final String formationId;
  final UserModel userModel;

  const FormationsDetails({
    Key? key,
    required this.userModel,
    required this.formationId,
  }) : super(key: key);

  @override
  _FormationsDetailsState createState() => _FormationsDetailsState();
}

class _FormationsDetailsState extends State<FormationsDetails> {
  Map<String, dynamic> formationsDetails = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFormationsDetails();
  }

  Future<void> _fetchFormationsDetails() async {
    // Afficher l'ID de la formation récupéré dans la console
    print('Formation ID: ${widget.formationId}');

    String apiUrl =
        'http://localhost:8000/formation/getFormation/${widget.formationId}';
    try {
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Accept-Charset': 'utf-8',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          formationsDetails = data;
          _isLoading = false;
        });
      } else {
        print('Failed to load formation details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading formation details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        leading: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.chevron_left_rounded,
            color: FlutterFlowTheme.of(context).primaryText,
            size: 32,
          ),
        ),
        title: Text(
          'Détails de formations ',
          style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Outfit',
                letterSpacing: 0,
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(
                        base64Decode(formationsDetails['poster']),
                        width: double.infinity,
                        height: 200, // Définir une hauteur fixe pour l'image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formationsDetails['intitule'] ?? '',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: 'Outfit',
                              ),
                        ),
                        Text(
                          formationsDetails['formateur'] ?? '',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: 'Outfit',
                                letterSpacing: 0,
                              ),
                        ),
                        Text(
                          'Responsable du formation: ${formationsDetails['responsable'] ?? 'Inconnu'}',
                          style:
                              FlutterFlowTheme.of(context).labelLarge.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0,
                                  ),
                        ),
                        Text(
                          'Numéro de responsable: ${formationsDetails['phoneNumber'] ?? 'Inconnu'}',
                          style:
                              FlutterFlowTheme.of(context).labelLarge.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0,
                                  ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                          child: Text(
                            formationsDetails['dateDeFormation'] ?? '',
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context).primary,
                                  letterSpacing: 0,
                                ),
                          ),
                        ),
                        Text(
                          formationsDetails['lieuFormation'] ?? '',
                          style:
                              FlutterFlowTheme.of(context).labelLarge.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0,
                                  ),
                        ),
                        Text(
                          formationsDetails['description'] ?? '',
                          style:
                              FlutterFlowTheme.of(context).labelLarge.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0,
                                  ),
                        ),
                        Divider(
                          height: 32,
                          thickness: 1,
                          color: FlutterFlowTheme.of(context).alternate,
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
