import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

class GenreEtatCivilRow extends StatefulWidget {
  final String genre;
  final String etatCivil;
  final ValueChanged<String> onEtatCivilChanged;
  final ValueChanged<String> onGenreChanged;

  const GenreEtatCivilRow({
    Key? key,
    required this.genre,
    required this.onGenreChanged,
    required this.etatCivil,
    required this.onEtatCivilChanged,
  }) : super(key: key);

  @override
  _GenreEtatCivilRowState createState() => _GenreEtatCivilRowState();
}

class _GenreEtatCivilRowState extends State<GenreEtatCivilRow> {
  String selectedGender = 'Féminin';
  String selectedCivilStatus = 'Célibataire';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 8, 0),
                child: DropdownButtonFormField(
                  value: selectedGender,
                  onChanged: (newGenre) {
                    setState(() {
                      selectedGender = newGenre.toString();
                    });
                    widget.onGenreChanged(newGenre.toString());
                  },
                  decoration: InputDecoration(
                    labelText: 'Genre',
                    labelStyle:
                        FlutterFlowTheme.of(context).labelMedium.override(
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
                  items: ['Féminin', 'Masculin', 'Autres']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 16, 0, 0),
                child: DropdownButtonFormField(
                  value: selectedCivilStatus,
                  onChanged: (newEtatCivil) {
                    setState(() {
                      selectedCivilStatus = newEtatCivil.toString();
                    });
                    widget.onEtatCivilChanged(newEtatCivil.toString());
                  },
                  decoration: InputDecoration(
                    labelText: 'État civil',
                    labelStyle:
                        FlutterFlowTheme.of(context).labelMedium.override(
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
                  items: [
                    'Célibataire',
                    'Marié(e)',
                    'Divorcé(e)',
                    'Veuf/Veuve',
                    'Autre',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
