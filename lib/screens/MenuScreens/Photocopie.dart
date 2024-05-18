import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:mira/Provider/user_model.dart';
import 'package:mira/Screens/MenuScreens/photoCopies.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPhotocopieWidget extends StatelessWidget {
  final String photocopieId;
  final UserModel userModel;

  const DetailsPhotocopieWidget({
    Key? key,
    required this.photocopieId,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _DetailsWidgetState(
      photocopieId: photocopieId,
      userModel: userModel,
    );
  }
}

class _DetailsWidgetState extends StatefulWidget {
  final String photocopieId;
  final UserModel userModel;

  const _DetailsWidgetState({
    Key? key,
    required this.photocopieId,
    required this.userModel,
  }) : super(key: key);

  @override
  __DetailsWidgetStateState createState() => __DetailsWidgetStateState();
}

class __DetailsWidgetStateState extends State<_DetailsWidgetState> {
  Map<String, dynamic> photocopiesDetails = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchphotocopieDetails();
  }

  Future<void> _fetchphotocopieDetails() async {
    print('photocopie ID: ${widget.photocopieId}');

    String apiUrl =
        'http://localhost:8000/photocopie/get_photocopie_by_id/${widget.photocopieId}';
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
          photocopiesDetails = data;
          _isLoading = false;
        });
      } else {
        print('Failed to load  details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading  details: $e');
    }
  }

  Future<void> _openPdf(BuildContext context) async {
    final url =
        'http://localhost:8000/photocopie/open_pdf/${widget.photocopieId}';

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

  Future<void> _downloadPdf(BuildContext context) async {
    final url =
        'http://localhost:8000/photocopie/download/${widget.photocopieId}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final documentsDirectory = await getApplicationDocumentsDirectory();
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final pdfFile =
            File('${documentsDirectory.path}/photocopie_$timestamp.pdf');
        await pdfFile.writeAsBytes(response.bodyBytes);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Détails de demande',
          style: FlutterFlowTheme.of(context).titleLarge,
        ),
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
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => PhotocopieWidget(
                userModel: widget.userModel,
              ),
            ));
          },
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1612815154858-60aa4c59eaa6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxfHxjb3BpZXJ8ZW58MHx8fHwxNzE1MDA3MTI5fDA&ixlib=rb-4.0.3&q=80&w=1080',
                      width: double.infinity,
                      height: 230,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Voir les détails de la demande ',
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                          fontFamily: 'Outfit',
                          color: Color(0xFF4B39EF),
                          fontSize: 18,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  // Generated code for this Divider Widget...
                  Divider(
                    height: 12,
                    thickness: 1,
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 12),
                    child: ElevatedButton(
                      onPressed: () => _openPdf(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: FlutterFlowTheme.of(context).primary,
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
                          style:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                    child: ElevatedButton(
                      onPressed: () => _downloadPdf(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: FlutterFlowTheme.of(context).accent1,
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
                          style:
                              FlutterFlowTheme.of(context).bodyLarge.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primary,
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
    );
  }
}
