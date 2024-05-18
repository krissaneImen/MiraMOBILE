// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutterflow_ui/flutterflow_ui.dart';
// import 'package:http/http.dart' as http;
// import 'package:mira/Provider/user_model.dart';

// class FormationsDetails extends StatefulWidget {
//   final UserModel userModel;

//   const FormationsDetails({
//     Key? key,
//     required this.userModel,
//   }) : super(key: key);

//   @override
//   _FormationsDetailsState createState() => _FormationsDetailsState();
// }

// class _FormationsDetailsState extends State<FormationsDetails> {
//   Map<String, dynamic> formationsDetails = {};
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchemploienseigant();
//   }

//   Future<void> _fetchemploienseigant() async {
//     String apiUrl =
//         'http://localhost:8000/emploiProf/get_emploi_by_cin/${widget.userModel.statut = 'Enseignant'}';
//     try {
//       var response = await http.get(
//         Uri.parse(apiUrl),
//         headers: {
//           'Accept-Charset': 'utf-8',
//         },
//       );

//       if (response.statusCode == 200) {
//         var data = json.decode(utf8.decode(response.bodyBytes));
//         setState(() {
//           formationsDetails = data;
//           _isLoading = false;
//         });
//       } else {
//         print('Failed to load details: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error loading details: $e');
//     }
//   }

//   Future<void> _fetchemploietudiant() async {
//     String apiUrl =
//         'http://localhost:8000/emploiProf/get_employment_list${widget.userModel.statut = 'Enseignant'}';
//     try {
//       var response = await http.get(
//         Uri.parse(apiUrl),
//         headers: {
//           'Accept-Charset': 'utf-8',
//         },
//       );

//       if (response.statusCode == 200) {
//         var data = json.decode(utf8.decode(response.bodyBytes));
//         setState(() {
//           formationsDetails = data;
//           _isLoading = false;
//         });
//       } else {
//         print('Failed to load details: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error loading details: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
//         automaticallyImplyLeading: false,
//         leading: InkWell(
//           splashColor: Colors.transparent,
//           focusColor: Colors.transparent,
//           hoverColor: Colors.transparent,
//           highlightColor: Colors.transparent,
//           onTap: () async {
//             Navigator.of(context).pop();
//           },
//           child: Icon(
//             Icons.chevron_left_rounded,
//             color: FlutterFlowTheme.of(context).primaryText,
//             size: 32,
//           ),
//         ),
//         title: Text(
//           'Détails de formations ',
//           style: FlutterFlowTheme.of(context).headlineMedium.override(
//                 fontFamily: 'Outfit',
//                 letterSpacing: 0,
//               ),
//         ),
//         actions: [],
//         centerTitle: false,
//         elevation: 0,
//       ),
     
//   }
// }
