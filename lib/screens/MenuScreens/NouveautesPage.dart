import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:mira/Provider/user_model.dart';
import 'package:mira/Screens/acceuil.dart';

class NouveautesPage extends StatefulWidget {
  final UserModel userModel;

  NouveautesPage({required this.userModel});

  @override
  _NouveautesPageState createState() => _NouveautesPageState();
}

class _NouveautesPageState extends State<NouveautesPage> {
  late Future<List<dynamic>> _nouveautes;

  @override
  void initState() {
    super.initState();
    _nouveautes = fetchNouveautes();
  }

  void navigateToAccueil() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => Accueil(
        userModel: widget.userModel, // Utilisez widget.userModel ici
      ),
    ));
  }

  Future<List<dynamic>> fetchNouveautes() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/nouv/list/'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data;
    } else {
      throw Exception('Failed to load nouveautes');
    }
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
          onPressed: () {
            navigateToAccueil();
          },
        ),
        title: Text(
          'Nouveautés',
          style: FlutterFlowTheme.of(context).titleLarge,
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _nouveautes,
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
                      color: Colors.grey[200],
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
                                fontSize: 18,
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
                                fontSize: 16,
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
          return SizedBox();
        },
      ),
    );
  }
}
