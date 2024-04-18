import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

class CustomDateField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final Function(DateTime pickedDate) onDatePicked;

  const CustomDateField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.onDatePicked,
  }) : super(key: key);

  @override
  _CustomDateFieldState createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
      child: Container(
        width: double.infinity,
        child: TextFormField(
          controller: widget.controller,
          readOnly:
              true, // rend le champ de texte en lecture seule pour empêcher la saisie manuelle
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
            suffixIcon: InkWell(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  locale: const Locale("fr", "FR"),
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2010),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  setState(() {
                    widget.controller.text = formattedDate;
                  });
                  widget.onDatePicked(pickedDate);
                }
              },
              child: Icon(
                Icons.calendar_today_outlined,
                color: Color(0xFF57636C),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
