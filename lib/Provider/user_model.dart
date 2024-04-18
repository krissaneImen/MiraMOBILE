import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mira/Screens/acceuil.dart';
import 'package:mira/Screens/AuthScreens/login.dart';

class UserModel extends ChangeNotifier {
  late String? _selectedRole;
  late String statut = '';
  late String _firstName = '';
  late String _lastName = '';
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
        notifyListeners();
        print('Prénom: $_firstName');
        print('Nom: $_lastName');
        print('Statut: $statut');
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

  Future<void> registerUser(BuildContext context) async {
    try {
      var url = Uri.parse('http://127.0.0.1:8000/users/register/');
      var headers = {'Content-Type': 'application/json'};
      var body = json.encode({
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

      var response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        // Affichez un message de succès si l'inscription réussit
        _showSnackBar('Inscription réussie');
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
        });
      } else {
        String errorMessage = response.body.isEmpty
            ? 'Erreur inconnue lors de l\'inscription'
            : response.body;
        throw Exception(
            'Erreur lors de l\'inscription: ${response.statusCode} - $errorMessage');
      }

      notifyListeners();
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

  UserModel getUserModel() {
    // Implémentez cette méthode pour obtenir userModel
    // Peut-être à partir d'un service ou d'un stockage local
    return UserModel(
        this._showSnackBar); // Exemple de création d'un nouvel objet UserModel
  }

  void updatePhoto(String base64Image) {
    _photoBase64 = base64Image;
    notifyListeners();
  }

  getPhotoUrl() {}

  // Future<void> sendEmail(BuildContext context) async {
  //   final String email = emailController.text.trim();

  //   // Make POST request to your backend API
  //   final Uri url = Uri.parse('http://localhost:8000/users/send_Email/');
  //   final http.Response response = await http.post(
  //     url,
  //     body: {'email': email},
  //   );

  //   // Handle response
  //   if (response.statusCode == 200) {
  //     // Password reset email sent successfully
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Password reset email sent successfully'),
  //       ),
  //     );
  //   } else {
  //     // Error sending password reset email
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Failed to send password reset email'),
  //       ),
  //     );
  //   }
  //}
}
