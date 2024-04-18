import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CustomPhoneNumberField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final Function(bool value) onInputValidated;

  const CustomPhoneNumberField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.onInputValidated,
  }) : super(key: key);

  @override
  _CustomPhoneNumberFieldState createState() => _CustomPhoneNumberFieldState();
}

class _CustomPhoneNumberFieldState extends State<CustomPhoneNumberField> {
  String? phoneNumberError;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
      child: IntlPhoneField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(
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
        initialCountryCode: 'TN',
        onChanged: (number) {
          bool isValidPhoneNumber = number.toString().length == 10;
          setState(() {
            phoneNumberError =
                isValidPhoneNumber ? null : 'Numéro de téléphone invalide';
          });
          widget.onInputValidated(isValidPhoneNumber);
        },
      ),
    );
  }
}
