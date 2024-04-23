import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mira/Screens/AuthScreens/login.dart';
import 'package:mira/Screens/acceuil.dart';

class UserModel extends ChangeNotifier {
  late String? _selectedRole;
  late String statut = '';
  late String _firstName = '';
  late String _lastName = '';
  late String date_de_delivrance;
  late String email = '';
  late int cin;
  late int phoneNumber;
  late bool passwordVisibility;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _cinController;
  late TextEditingController _dateDeDelivranceController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController
      _statutController; // Ajout du contrôleur pour le champ "statut"
  late TextEditingController _passwordController;
  late TextEditingController _resetPasswordController;
  late Function(String) _showSnackBar;
  late String _photoBase64;

  UserModel(this._showSnackBar) {
    passwordVisibility = false;
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _cinController = TextEditingController();
    _dateDeDelivranceController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _statutController =
        TextEditingController(); // Initialisation du contrôleur pour le champ "statut"
    _passwordController = TextEditingController();
    _resetPasswordController = TextEditingController();
  }
  void setSelectedRole(String? role) {
    _selectedRole = role;
    notifyListeners();
  }

  TextEditingController get firstNameController => _firstNameController;
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController get cinController => _cinController;
  TextEditingController get dateDeDelivranceController =>
      _dateDeDelivranceController;
  TextEditingController get emailController => _emailController;
  TextEditingController get phoneNumberController => _phoneNumberController;
  TextEditingController get statutController => _statutController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get resetPasswordController => _resetPasswordController;
  String? getPhotoBase64() => _photoBase64;
//Connexion
  Future<void> loginUser(BuildContext context) async {
    try {
      var url = Uri.parse('http://127.0.0.1:8000/users/login/');
      var headers = {'Content-Type': 'application/json'};
      var body = json.encode({
        'cin': _cinController.text,
        'password': _passwordController.text,
      });

      var response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        var userData = json.decode(response.body);

        _firstName = userData['firstName'] ?? '';
        _lastName = userData['lastName'] ?? '';
        statut = userData['statut'] ?? '';
        email = userData['email'] ?? '';
        int? cin = userData['cin'] != null
            ? int.parse(userData['cin'].toString())
            : null;
        int? phoneNumber = userData['phoneNumber'] != null
            ? int.parse(userData['phoneNumber'].toString())
            : null;
        DateTime? date_de_delivrance;
        String? dateString = userData['dateDeDelivrance'];

        if (dateString != null) {
          try {
            date_de_delivrance = DateTime.parse(dateString);
          } catch (e) {
            // Gérer l'erreur de format de date ici
            print('Erreur lors de l\'analyse de la date: $e');
          }
        }

        notifyListeners();
        print('Prénom: $_firstName');
        print('Nom: $_lastName');
        print('Statut: $statut');
        print('email: $email');
        print('cin :$cin');
        print('phoneNumber: $phoneNumber');
        print('date de del: $date_de_delivrance');
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Accueil(userModel: this),
        ));
      } else {
        String errorMessage = response.body.isEmpty
            ? 'Erreur inconnue lors de la connexion'
            : response.body;
        throw Exception(
            'Erreur lors de la connexion: ${response.statusCode} - $errorMessage');
      }
    } catch (e) {
      _showSnackBar(e.toString());
    }
  }

  @override
  void dispose() {
    passwordVisibility = false;
    _firstNameController.dispose();
    _lastNameController.dispose();
    _cinController.dispose();
    _dateDeDelivranceController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _statutController.dispose();
    _passwordController.dispose();
    _resetPasswordController.dispose();
    super.dispose();
  }

  String getFullName() {
    return '$_firstName $_lastName';
  }

  String getstatut() {
    return '$statut';
  }

  Future<void> registerUser(BuildContext context) async {
    try {
      var userUrl = Uri.parse('http://127.0.0.1:8000/users/register/');
      var profileUrl = Uri.parse('http://127.0.0.1:8000/profil/create/');

      var headers = {'Content-Type': 'application/json'};
      var userBody = json.encode({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'cin': _cinController.text,
        'dateDeDelivrance': _dateDeDelivranceController.text,
        'email': _emailController.text,
        'phoneNumber': int.parse(_phoneNumberController.text),
        'statut': _selectedRole,
        'password': _passwordController.text,
        'resetPassword': _resetPasswordController.text,
      });

      var userResponse =
          await http.post(userUrl, headers: headers, body: userBody);

      print('User Response Status Code: ${userResponse.statusCode}');
      print('User Response Body: ${userResponse.body}');

      if (userResponse.statusCode == 201) {
        var profileBody = json.encode({
          'cartCin': _cinController.text,
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
          'dateDeDelivrance': _dateDeDelivranceController.text,
          'email': _emailController.text,
          'phoneNumber': _phoneNumberController.text,
        });

        var profileResponse =
            await http.post(profileUrl, headers: headers, body: profileBody);

        print('Profile Response Status Code: ${profileResponse.statusCode}');
        print('Profile Response Body: ${profileResponse.body}');

        if (profileResponse.statusCode == 201) {
          _showSnackBar('Inscription réussie');
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => LoginPage(),
            ));
          });
        } else {
          String errorMessage = profileResponse.body.isEmpty
              ? 'Erreur inconnue lors de la création du profil'
              : profileResponse.body;
          throw Exception(
              'Erreur lors de la création du profil: ${profileResponse.statusCode} - $errorMessage');
        }
      } else {
        String errorMessage = userResponse.body.isEmpty
            ? 'Erreur inconnue lors de l\'inscription'
            : userResponse.body;
        throw Exception(
            'Erreur lors de l\'inscription: ${userResponse.statusCode} - $errorMessage');
      }

      notifyListeners();
    } catch (e) {
      _showSnackBar('Erreur lors de l\'inscription: $e');
      print('Error during registration: $e');
    }
  }
}
