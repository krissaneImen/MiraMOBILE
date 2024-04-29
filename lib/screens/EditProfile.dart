import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mira/Models/ProfileModel.dart';
import 'package:mira/Widgets/EditProfilWidgets/AdresseCodePostalRow.dart';
import 'package:mira/Widgets/EditProfilWidgets/Adressearabe.dart';
import 'package:mira/Widgets/EditProfilWidgets/DateLieuNaissanceRow.dart';
import 'package:mira/Widgets/EditProfilWidgets/CINDateDelivranceRow.dart';
import 'package:mira/Widgets/EditProfilWidgets/GenderRow.dart';
import 'package:mira/Widgets/EditProfilWidgets/NomPrenomArabeRow.dart';
import 'package:mira/Widgets/EditProfilWidgets/NomPrenomRow.dart';
import 'package:intl/intl.dart';

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
  late DateTime dateNaissance;
  late String lieuNaissanceArabe = 'Chargement .....';
  late String adresseArabe = 'Chargement ......';
  late String delegationArabe = 'Chargement .....';
  late String nomArabe = 'Chargement ....';
  late String prenom_arabe = 'Chargement .....';
  late String _profileImageUrl;
  late String _email = 'Chargement ....';
  late String PhoneNumber;
  late String nationalite = '';
  late String nom = '';
  late String prenom = '';
  late DateTime _dateDelivrance;
  late ProfileModel model;
  bool _isLoading = true;
  String base64Image = '';
  late DateTime _selectedDate;
  late String formattedDate = '';
  String delegation = '';
  String lieuDeNaissanceArabe = '';
  late String lieuNaissance = '';
  late String adresse = '';
  @override
  void initState() {
    super.initState();
    model = ProfileModel();
    _profileImageUrl = '';
    _fetchProfileData();
    _selectedDate = DateTime.now();
    // Convertir la date de délivrance en format ISO 8601
  }

  Image imageFromBase64String(String base64String) {
    Uint8List bytes = base64Decode(base64String);
    return Image.memory(bytes, fit: BoxFit.cover);
  }

  String base64String(File file) {
    try {
      if (!file.existsSync()) {
        print('Le fichier n\'existe pas.');
        return '';
      }
      List<int> imageBytes = file.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);

      return base64Image;
    } catch (e) {
      print('Erreur lors de la lecture du fichier : $e');
      return '';
    }
  }

  Future<File?> compressImage(File imageFile) async {
    try {
      int quality = 85;
      List<int>? result = await FlutterImageCompress.compressWithFile(
        imageFile.path,
        quality: quality,
      );

      if (result != null) {
        File compressedFile = File(
            '${imageFile.parent.path}/compressed_${imageFile.path.split('/').last}');
        await compressedFile.writeAsBytes(result);
        return compressedFile;
      } else {
        return null;
      }
    } catch (e) {
      print('Erreur lors de la compression de l\'image : $e');
      return null;
    }
  }

  Future<void> _getImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        File imageFile = File(image.path);
        compressImage(imageFile).then((compressedImage) {
          if (compressedImage != null) {
            base64Image = base64String(compressedImage);
            // Vérification si la chaîne base64Image est vide ou non
            if (base64Image.isEmpty) {
              print('La chaîne base64Image est vide.');
            } else {
              print('La chaîne base64Image n\'est pas vide : $base64Image');
            }
            setState(() {
              _profileImageUrl = image.path; // Met à jour l'image du profil
            });
          } else {
            print('Erreur lors de la compression de l\'image');
          }
        });
      }
    });
  }

  Future<void> _fetchProfileData() async {
    String apiUrl =
        'http://192.168.1.21:8000/profil/profiles/cin/${widget.cin}';

    try {
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var profileData = json.decode(response.body);

        setState(() {
          String email = profileData['email'];
          _email = email;
          String phoneNumber = profileData['phoneNumber'];
          PhoneNumber = phoneNumber;
          String nomfr = profileData['firstName'];
          nom = nomfr;
          String prenomArabe = profileData['prenom_arabe'] ?? '';
          prenom_arabe = prenomArabe;
          String nomArabbe = profileData['nomArabe'] ?? '';
          nomArabe = nomArabbe;
          String prenomfr = profileData['lastName'];
          prenom = prenomfr;
          String lieuNaissanceArabee = profileData['lieuNaissanceArabe'] ?? '';
          lieuNaissanceArabe = lieuNaissanceArabee;
          String adresseArabee = profileData['adresseArabe'] ?? '';
          adresseArabe = adresseArabee;
          String delegationArabee = profileData['delegationArabe'] ?? '';
          delegationArabe = delegationArabee;
          String genres = profileData['delegationArabe'] ?? '';
          genre = genres;
          String dateDelivrance = profileData['dateDeDelivrance'];
          _dateDelivrance = DateTime.parse(dateDelivrance);
          String base64Image = profileData['image'];
          Image image = imageFromBase64String(base64Image);
          String Gouvernerat = profileData['gouvernerat'] ?? '';
          gouvernerat = Gouvernerat;
          String LieuNaissance = profileData['lieuNaissance'] ?? '';
          lieuNaissance = LieuNaissance;
          String etatCivile = profileData['etatCivil'] ?? '';
          etatCivil = etatCivile;
          String nationalites = profileData['nationalite'] ?? '';
          nationalite = nationalites;
          String dateNaissances = profileData['dateNaissance'];
          dateNaissance = DateTime.parse(dateNaissances);
          String lieuNais = profileData['lieuNaissance'] ?? '';
          lieuNaissance = lieuNais;
          String Adrs = profileData['adresse'] ?? '';
          adresse = Adrs;
          String delegations = profileData['delegation'] ?? '';
          delegation = delegations;
          String codePostals = profileData['codePostal'] ?? '';
          codePostal = codePostals;
          _isLoading = false;
        });
      } else {
        print('Failed to load profile data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading profile data: $e');
    }
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
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: _profileImageUrl.isNotEmpty
                                ? Image.file(
                                    File(_profileImageUrl),
                                    width: 90,
                                    height: 90,
                                    fit: BoxFit.cover,
                                  )
                                : Icon(
                                    Icons.account_circle_outlined,
                                    size: 90,
                                    color: Colors.grey,
                                  ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: GestureDetector(
                              onTap: _getImageFromGallery,
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.black54,
                                child: Icon(
                                  Icons.add_photo_alternate,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16), // Espace
                      CINDateDelivranceRow(
                        cin: widget.cin,
                        dateDelivrance: _dateDelivrance,
                      ),
                      NomPrenomRow(
                        nom: nom ?? '',
                        prenom: prenom ?? '',
                      ),
                      Container(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: TextFormField(
                          initialValue: _email,
                          onChanged: (value) {
                            setState(() {
                              _email =
                                  value; // Mettre à jour la valeur de _email lorsque l'utilisateur change le texte dans le champ
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
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
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF14181B),
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: TextFormField(
                          initialValue: PhoneNumber,
                          onChanged: (value) {
                            setState(() {
                              PhoneNumber =
                                  value; // Mettre à jour la valeur de PhoneNumber lorsque l'utilisateur change le texte dans le champ
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Numéro de Téléphone',
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
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
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF14181B),
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ),
                      DateLieuNaissanceRow(),
                      AdresseCodePostalRow(),
                      GenreEtatCivilRow(),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Nationalité',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
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
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
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
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    gouvernerat =
                                        value; // Mettre à jour la valeur de gouvernerat lorsque l'utilisateur change le texte dans le champ
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: 'Gouvernerat',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
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
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
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
                      ),

                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    delegation = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: 'Délégation',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
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
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
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
                      ),
                      NomPrenomArabeRow(),
                      AdresseMaotamediaRow(
                        adresse: '',
                        maotamedia: '',
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                              child: TextFormField(
                                textAlign: TextAlign.right,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'مكان الولادة',
                                  hintText: 'مكان الولادة',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Color(0xFF57636C),
                                        fontSize: 14,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
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
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
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
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: FFButtonWidget(
                          onPressed: () {
                            model.updateProfile(
                              email: _email,
                              phoneNumber: PhoneNumber,
                              nom: nom,
                              prenom: prenom,
                              cin: widget.cin,
                              dateDelivrance: _dateDelivrance,
                              prenomArabe: prenom_arabe,
                              nomArabe: nomArabe,
                              lieuNaissanceArabe: lieuNaissanceArabe,
                              nationalite: nationalite,
                              gouvernerat: gouvernerat,
                              delegation: delegation,
                              adresseArabe: adresseArabe,
                              delegationArabe: delegationArabe,
                              genre: genre,
                              etatCivil: etatCivil,
                              dateNaissance: dateNaissance,
                              lieuNaissance: lieuNaissance,
                              adresse: adresse,
                              codePostal: codePostal,
                              image:
                                  base64Image, // Utilisation de l'image encodée en base64
                            );
                          },
                          text: 'Enregistrer',
                          options: FFButtonOptions(
                            width: 270,
                            height: 50,
                            color: Color(0xFF4B39EF),
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            elevation: 3,
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ]),
              ),
      ),
    );
  }
}
