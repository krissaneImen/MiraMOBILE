import 'package:flutter/material.dart';

class NationaliteRow extends StatefulWidget {
  final String nationalite;
  final ValueChanged<String> onChanged;

  const NationaliteRow({
    Key? key,
    required this.nationalite,
    required this.onChanged,
  }) : super(key: key);

  @override
  _NationaliteRowState createState() => _NationaliteRowState();
}

class _NationaliteRowState extends State<NationaliteRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
            child: TextFormField(
              onChanged: widget.onChanged,
              initialValue: widget.nationalite,
              decoration: InputDecoration(
                labelText: 'Nationalité',
                labelStyle: TextStyle(
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
              style: TextStyle(
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
