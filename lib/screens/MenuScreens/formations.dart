import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:mira/Provider/user_model.dart';
import 'package:mira/Screens/acceuil.dart'; // Assuming the path to Accueil is correct

class FormationList extends StatefulWidget {
  final UserModel userModel; // Assuming UserModel is the type of userModel

  const FormationList({required this.userModel});

  @override
  _FormationListState createState() => _FormationListState();
}

class _FormationListState extends State<FormationList> {
  late Future<List<dynamic>> _formationsFuture;

  Future<List<dynamic>> fetchFormations() async {
    final response = await http
        .get(Uri.parse('http://172.16.25.125:8000/fichier/pdffiles/'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load formations');
    }
  }

  @override
  void initState() {
    super.initState();
    _formationsFuture = fetchFormations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Formations'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => Accueil(
                userModel: widget.userModel,
              ),
            ));
          },
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _formationsFuture,
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data![index]['intitule'] ?? ''),
                  subtitle: Text(snapshot.data![index]['description'] ?? ''),
                );
              },
            );
          } else {
            return Center(child: Text('Aucune donnée à afficher'));
          }
        },
      ),
    );
  }
}

class PdfViewer extends StatelessWidget {
  final PDFDocument document;

  PdfViewer(this.document);

  @override
  Widget build(BuildContext context) {
    return PDFViewer(
      document: document,
      zoomSteps: 1,
    );
  }
}
