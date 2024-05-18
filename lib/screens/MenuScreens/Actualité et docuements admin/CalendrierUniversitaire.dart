import 'dart:convert';
import 'dart:io';
import 'package:mira/Screens/MenuScreens/Actualit%C3%A9%20et%20docuements%20admin/Calendriers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:http/http.dart' as http;
import 'package:mira/Provider/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Calendrier extends StatefulWidget {
  final UserModel userModel;
  final String calendrierId;

  const Calendrier({
    Key? key,
    required this.userModel,
    required this.calendrierId,
  }) : super(key: key);

  @override
  State<Calendrier> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<Calendrier> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic> calendrierDetails = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCalendrierDetails();
  }

  Future<void> _fetchCalendrierDetails() async {
    // Afficher l'ID du calendrier récupéré dans la console
    print('Calendrier ID: ${widget.calendrierId}');

    String apiUrl =
        'http://localhost:8000/calendrier/get_Calendrier_by_id/${widget.calendrierId}';
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
          calendrierDetails = data;
          _isLoading = false;
        });
      } else {
        print('Failed to load calendrier details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading calendrier details: $e');
    }
  }

  Future<void> _downloadPdf() async {
    final url =
        'http://localhost:8000/calendrier/download/${widget.calendrierId}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final documentsDirectory = await getApplicationDocumentsDirectory();
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final pdfFile =
            File('${documentsDirectory.path}/calendrier_$timestamp.pdf');
        await pdfFile.writeAsBytes(response.bodyBytes);

        // Afficher une fenêtre modale pour informer l'utilisateur
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Téléchargement réussi'),
              content: Text(
                  'PDF téléchargé avec succès. Emplacement : ${pdfFile.path}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Fermer la fenêtre modale
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        print('Erreur lors du téléchargement du PDF: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur lors du téléchargement du PDF: $e');
    }
  }

  Future<void> _openPdf() async {
    final url =
        'http://localhost:8000/calendrier/open_pdf/${widget.calendrierId}';

    try {
      // Ouvrir le PDF dans une visionneuse PDF externe
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Impossible de lancer $url';
      }
    } catch (e) {
      print('Erreur lors de l\'ouverture du PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CalendriersWidget(userModel: widget.userModel)),
              );
            },
          ),
          title: Text(
            'Calendrier universitaire',
            style: FlutterFlowTheme.of(context).titleLarge,
          ),
          centerTitle: false,
          elevation: 0,
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                top: true,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 16, 0, 0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 230,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 12,
                                            color: Color(0x33000000),
                                            offset: Offset(
                                              0,
                                              5,
                                            ),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(2),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            'https://images.unsplash.com/photo-1633526543814-9718c8922b7a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxNnx8Y2FsZW5kcmllciUyMHxlbnwwfHx8fDE3MTQ0NzI3OTh8MA&ixlib=rb-4.0.3&q=80&w=1080',
                                            width: double.infinity,
                                            height: 230,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 16, 0, 0),
                                    child: Text(
                                      'Calendrier Universitaire',
                                      style: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .override(
                                            fontFamily: 'Outfit',
                                            letterSpacing: 0,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 0, 0),
                                    child: Text(
                                      'Consulter et télécharger votre calendrier universitaire.',
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
                            Divider(
                              height: 12,
                              thickness: 1,
                              color: FlutterFlowTheme.of(context).alternate,
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 8, 16, 12),
                              child: ElevatedButton(
                                onPressed: _openPdf,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Voir le PDF',
                                    style: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                              child: ElevatedButton(
                                onPressed: _downloadPdf,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).accent1,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Télécharger le PDF',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          letterSpacing: 0,
                                        ),
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
      ),
    );
  }
}
