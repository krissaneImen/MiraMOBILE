import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

class NomPrenomRow extends StatefulWidget {
  final String nom;
  final String prenom;
  final Function(String) onNomChanged;
  final Function(String) onPrenomChanged;

  const NomPrenomRow({
    required this.nom,
    required this.prenom,
    required this.onNomChanged,
    required this.onPrenomChanged,
  });

  @override
  _NomPrenomRowState createState() => _NomPrenomRowState();
}

class _NomPrenomRowState extends State<NomPrenomRow> {
  late TextEditingController _nomController;
  late TextEditingController _prenomController;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.nom);
    _prenomController = TextEditingController(text: widget.prenom);
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 16, 8, 0),
            child: TextFormField(
              controller: _nomController,
              onChanged: widget.onNomChanged,
              decoration: InputDecoration(
                labelText: 'Nom',
                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF57636C),
                      fontSize: 14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                    ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFE0E3E7),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF4B39EF),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Plus Jakarta Sans',
                    color: Color(0xFF14181B),
                    fontSize: 14,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8, 16, 0, 0),
            child: TextFormField(
              controller: _prenomController,
              onChanged: widget.onPrenomChanged,
              decoration: InputDecoration(
                labelText: 'Prénom',
                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF57636C),
                      fontSize: 14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                    ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFE0E3E7),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF4B39EF),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Plus Jakarta Sans',
                    color: Color(0xFF14181B),
                    fontSize: 14,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
