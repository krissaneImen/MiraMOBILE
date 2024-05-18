import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final List<String> autofillHints;
  final TextInputType keyboardType;
  final String? Function(String?)? validator; // Fonction de validation

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.autofillHints,
    required this.keyboardType,
    this.validator, // Validator optionnel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
      child: Container(
        width: double.infinity,
        child: TextFormField(
          controller: controller,
          autofillHints: autofillHints,
          obscureText: false,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: FlutterFlowTheme.of(context).labelLarge.override(
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
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFE0E3E7),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFE0E3E7),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Color(0xFFF1F4F8),
            
          ),
          style: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'Plus Jakarta Sans',
                color: Color(0xFF101213),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              
          keyboardType: keyboardType,
          validator: validator, // Utilisation de la fonction de validation
        ),
      ),
    );
  }
}
