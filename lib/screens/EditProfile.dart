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
  late ProfileModel model;
  bool _isLoading = true;
  String base64Image = '';
  late DateTime _selectedDate = DateTime.now();
  String formattedDate = '';
  String delegation = '';
  String lieuDeNaissanceArabe = '';
  late String lieuNaissance = '';
  late String adresse = '';

  @override
  void initState() {
    super.initState();
    model = ProfileModel();
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

  bool isValidBase64(String str) {
    final RegExp base64Regex = RegExp(r'^[A-Za-z0-9+/]+[=]{0,2}$');
    return base64Regex.hasMatch(str);
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

  Future<void> _fetchProfileData() async {
    String apiUrl =
        'http://172.16.26.185:8000/profil/profiles/cin/${widget.cin}';

    try {
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var profileData = json.decode(response.body);

        setState(() {
          _email = profileData['email'] ?? '';
          PhoneNumber = profileData['phoneNumber'] ?? '';
          nom = profileData['firstName'] ?? '';
          prenom_arabe = profileData['prenom_arabe'] ?? '';
          nomArabe = profileData['nomArabe'] ?? '';
          prenom = profileData['lastName'] ?? '';
          lieuNaissanceArabe = profileData['lieuNaissanceArabe'] ?? '';
          adresseArabe = profileData['adresseArabe'] ?? '';
          delegationArabe = profileData['delegationArabe'] ?? '';
          genre = profileData['genre'] ?? '';
          _dateDelivrance = DateTime.parse(profileData['dateDeDelivrance']);
          _profileImageUrl = profileData['image'] ?? '';
          gouvernerat = profileData['gouvernerat'] ?? '';
          lieuNaissance = profileData['lieuNaissance'] ?? '';
          etatCivil = profileData['etatCivil'] ?? '';
          nationalite = profileData['nationalite'] ?? '';

          String dateNaissanceString = profileData['dateNaissance'] ?? '';
          dateNaissance = dateNaissanceString.isNotEmpty
              ? DateTime.parse(dateNaissanceString)
              : DateTime
                  .now(); // Vérification si la date n'est pas vide avant de la parser

          adresse = profileData['adresse'] ?? '';
          codePostal = profileData['codePostal'] ?? '';
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
                            child: _profileImageUrl.isNotEmpty &&
                                    isValidBase64(_profileImageUrl)
                                ? Image.memory(
                                    base64Decode(_profileImageUrl),
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
                        nom: nom,
                        prenom: prenom,
                        onNomChanged: (value) {
                          setState(() {
                            nom = value;
                          });
                        },
                        onPrenomChanged: (value) {
                          setState(() {
                            prenom = value;
                          });
                        },
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
                            filled: true,
                            fillColor: Colors.white,
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
                            filled: true,
                            fillColor: Colors.white,
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
                      DateLieuNaissanceRow(
                        selectedDate: _selectedDate,
                        onDateChanged: (newDate) {
                          setState(() {
                            _selectedDate = newDate;
                          });
                        },
                        lieuNaissance: lieuNaissance,
                        onLieuNaissanceChanged: (newLieuNaissance) {
                          setState(() {
                            lieuNaissance = newLieuNaissance;
                          });
                        },
                      ),

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
                                  labelStyle: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  hintStyle: TextStyle(
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

  Future<void> _getImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        File imageFile = File(image.path);
        compressImage(imageFile).then((compressedImage) {
          if (compressedImage != null) {
            base64Image = base64String(compressedImage);
            if (base64Image.isEmpty || !isValidBase64(base64Image)) {
              print('La chaîne base64Image est vide ou invalide.');
            } else {
              print('La chaîne base64Image est valide : $base64Image');
              setState(() {
                _profileImageUrl = base64Image;
              });
            }
          } else {
            print('Erreur lors de la compression de l\'image');
          }
        });
      }
    });
  }
}
