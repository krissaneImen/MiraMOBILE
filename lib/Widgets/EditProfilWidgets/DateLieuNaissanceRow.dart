import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

class DateLieuNaissanceRow extends StatefulWidget {
  @override
  _DateLieuNaissanceRowState createState() => _DateLieuNaissanceRowState();
}

class _DateLieuNaissanceRowState extends State<DateLieuNaissanceRow> {
  late DateTime _selectedDate;
  TextEditingController _lieuNaissanceController = TextEditingController();
  late String lieuNaissance = '';
  @override
  void initState() {
    super.initState();
    // Initialiser la date sélectionnée à la date actuelle
    _selectedDate = DateTime.now();
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
              readOnly: true, // Rendre le champ en lecture seule
              decoration: InputDecoration(
                labelText: 'Date de naissance',
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
                // Autres propriétés de décoration selon vos besoins
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Plus Jakarta Sans',
                    color: Color(0xFF14181B),
                    fontSize: 14,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                  ),
              onTap: () async {
                // Afficher le dialogue de sélection de date
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );

                // Mettre à jour la date sélectionnée si l'utilisateur a choisi une date
                if (pickedDate != null && pickedDate != _selectedDate) {
                  setState(() {
                    _selectedDate = pickedDate;
                  });
                }
              },
              // Afficher la date sélectionnée dans le champ
              controller: TextEditingController(
                text: DateFormat('dd/MM/yyyy').format(_selectedDate),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8, 16, 0, 0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  lieuNaissance = value;
                });
              },
              controller: _lieuNaissanceController,
              decoration: InputDecoration(
                labelText: 'Lieu de naissance',
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
              // initialValue: lieuNaissance.isNotEmpty ? lieuNaissance : null,
            ),
          ),
        ),
      ],
    );
  }
}
