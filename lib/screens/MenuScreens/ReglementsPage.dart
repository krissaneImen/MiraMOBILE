import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutterflow_ui/flutterflow_ui.dart';

class ReglementsPage extends StatefulWidget {
  @override
  _ReglementsPageState createState() => _ReglementsPageState();
}

class _ReglementsPageState extends State<ReglementsPage> {
  Future<List<dynamic>> fetchReglements() async {
    final response = await http.get(Uri.parse(
        'http://172.16.25.125:8000/documentation/reglement_interieur/'));

    if (response.statusCode == 200) {
      // Si la requête réussit, décoder les données JSON
      List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data;
    } else {
      // En cas d'erreur, lancer une exception
      throw Exception('Failed to load reglements');
    }
  }

  late Future<List<dynamic>> _reglements;

  @override
  void initState() {
    super.initState();
    _reglements = fetchReglements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: FlutterFlowTheme.of(context).primaryText,
            size: 30,
          ),
          onPressed: () async {
            Navigator.pop(context); // Retourner vers la page précédente
          },
        ),
        title: Text(
          'Règlement Intérieur',
          style: FlutterFlowTheme.of(context).titleLarge,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _reglements,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Container(
                    width: 500,
                    constraints: BoxConstraints(maxWidth: 570),
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Couleur de fond
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 12, 0, 8),
                            child: Text(
                              '${snapshot.data![index]['titre']}',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 18, // Taille de police du titre
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 4, 12, 16),
                            child: Text(
                              '${snapshot.data![index]['description']}',
                              style: TextStyle(
                                fontSize:
                                    16, // Taille de police de la description
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return SizedBox(); // Retourne un widget vide par défaut
        },
      ),
    );
  }
}
