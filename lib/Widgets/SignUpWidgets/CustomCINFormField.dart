import 'package:flutter/material.dart';

class CustomCINFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final List<String> autofillHints;

  const CustomCINFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.autofillHints,
  }) : super(key: key);

  @override
  _CustomCINFormFieldState createState() => _CustomCINFormFieldState();
}

class _CustomCINFormFieldState extends State<CustomCINFormField> {
  bool _isTyping = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
      child: TextFormField(
        controller: widget.controller,
        autofillHints: widget.autofillHints,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (!_isTyping) {
            setState(() {
              _isTyping = true;
            });
          }
          setState(
              () {}); // Permet de mettre à jour l'état du widget lors de la saisie
        },
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                fontFamily: 'Plus Jakarta Sans',
                color: Color(0xFF57636C),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFF1F4F8),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF4B39EF),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Color(0xFFF1F4F8),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red, // Couleur de bordure en cas d'erreur
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red, // Couleur de bordure en cas d'erreur
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          errorText: _isTyping ? _validateCIN(widget.controller.text) : null,
        ),
      ),
    );
  }

  String? _validateCIN(String? value) {
    if (value == null || value.length != 8 || int.tryParse(value) == null) {
      return 'Le CIN doit comporter exactement 8 chiffres.';
    }
    return null; // Retourne null si la validation réussit
  }
}
