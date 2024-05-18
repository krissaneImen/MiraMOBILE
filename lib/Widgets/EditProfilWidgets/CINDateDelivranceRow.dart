import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

class Editprofil extends StatefulWidget {
  const Editprofil({
    Key? key,
    required this.cin,
  }) : super(key: key);
  final String cin;

  @override
  State<Editprofil> createState() => _EditprofilWidgetState();
}

class _EditprofilWidgetState extends State<Editprofil> {
  late String codePostal = '';
  late String gouvernerat = '';
  late String genre = '';
  late String etatCivil = '';
  late DateTime dateNaissance = DateTime.now();
  late String lieuNaissanceArabe = '';
  late String adresseArabe = '';
  late String delegationArabe = '';
  late String nomArabe = '';
  late String prenom_arabe = '';
  late String _profileImageUrl = '';
  late String _email = '';
  late String PhoneNumber = '';
  late String nationalite = '';
  late String nom = '';
  late String prenom = '';
  late DateTime _dateDelivrance = DateTime.now();
  late bool _isLoading = true;
  late String base64Image = '';
  late DateTime _selectedDate = DateTime.now();
  late String formattedDate = '';
  late String delegation = '';
  late String lieuNaissance = '';
  late String adresse = '';

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
    _selectedDate = DateTime.now();
  }

  Future<void> _fetchProfileData() async {
    // Implement your profile data fetching logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editer Votre Profil'),
      ),
      body: SingleChildScrollView(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    // Your profile editing widgets here
                    CINDateDelivranceRow(
                      cin: widget.cin,
                      dateDelivrance: _dateDelivrance,
                      onDateChanged: (newDate) {
                        setState(() {
                          _dateDelivrance = newDate;
                        });
                      },
                    ),
                    // Other profile editing widgets...
                  ],
                ),
              ),
      ),
    );
  }
}

class CINDateDelivranceRow extends StatefulWidget {
  final String cin;
  final DateTime dateDelivrance;
  final ValueChanged<DateTime> onDateChanged;

  CINDateDelivranceRow({
    required this.cin,
    required this.dateDelivrance,
    required this.onDateChanged,
  });

  @override
  _CINDateDelivranceRowState createState() => _CINDateDelivranceRowState();
}

class _CINDateDelivranceRowState extends State<CINDateDelivranceRow> {
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(
        text: DateFormat('dd/MM/yyyy').format(widget.dateDelivrance));
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.dateDelivrance,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != widget.dateDelivrance) {
      setState(() {
        widget.onDateChanged(picked);
        _dateController.text = picked.toString();
      });
    }
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
              initialValue: widget.cin,
              enabled: false,
              keyboardType: TextInputType.number,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Numéro de carte d\'identité nationale',
                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF57636C),
                      fontSize: 14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                    ),
                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
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
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFFF5963),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFFF5963),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
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
            child: GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: 'Date de Délivrance',
                    labelStyle:
                        FlutterFlowTheme.of(context).labelMedium.override(
                              fontFamily: 'Plus Jakarta Sans',
                              color: Color(0xFF57636C),
                              fontSize: 14,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                            ),
                    hintText: 'Date de Délivrance',
                    hintStyle:
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
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFFF5963),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFFF5963),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
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
          ),
        ),
      ],
    );
  }
}
