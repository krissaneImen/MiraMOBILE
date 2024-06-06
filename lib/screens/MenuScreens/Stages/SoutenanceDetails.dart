import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

class SoutenanceDetails extends StatelessWidget {
  final Map<String, dynamic> soutenanceData;

  const SoutenanceDetails({
    Key? key,
    required this.soutenanceData,
  }) : super(key: key);

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
            Icons.arrow_back_rounded,
            color: FlutterFlowTheme.of(context).primaryText,
            size: 30,
          ),
        ),
        title: Text(
          'Détails de la soutenance',
          style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Outfit',
                letterSpacing: 0,
              ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Table(
            columnWidths: {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(2),
            },
            border: TableBorder.all(color: Colors.grey),
            children: [
              _buildTableRow(context, 'ID', soutenanceData['id']),
              _buildTableRow(
                  context, 'Nom Rapporteur', soutenanceData['NomRaporteur']),
              _buildTableRow(
                  context, 'CIN Rapporteur', soutenanceData['CinRaporteur']),
              _buildTableRow(context, 'Nom Président Jury',
                  soutenanceData['NomPresidentJuri']),
              _buildTableRow(context, 'CIN Président Jury',
                  soutenanceData['CinPresidentJuri']),
              _buildTableRow(context, 'Année Universitaire',
                  soutenanceData['Anneeuniversitaire']),
              _buildTableRow(
                  context, 'Nom Encadreur', soutenanceData['NomEncadreur']),
              _buildTableRow(
                  context, 'CIN Encadreur', soutenanceData['CinEncadreur']),
              _buildTableRow(context, 'Date Jury', soutenanceData['dateJury']),
              _buildTableRow(
                  context, 'Nature Stage', soutenanceData['NatureStage']),
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Étudiants',
                      style: FlutterFlowTheme.of(context).labelLarge.override(
                            fontFamily: 'Readex Pro',
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          (soutenanceData['Etudiants'] as List).map((etudiant) {
                        return Text(
                            '${etudiant['NomEtudiant']} (${etudiant['Cin']})');
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(BuildContext context, String label, String? value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: FlutterFlowTheme.of(context).labelLarge.override(
                  fontFamily: 'Readex Pro',
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value ?? 'Inconnu',
            style: FlutterFlowTheme.of(context).labelLarge.override(
                  fontFamily: 'Readex Pro',
                ),
          ),
        ),
      ],
    );
  }
}
