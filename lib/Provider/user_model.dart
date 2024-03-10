import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  late bool passwordVisibility;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _cinController;
  late TextEditingController _dateDeDelivranceController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _statutController;
  late TextEditingController _passwordController;
  late TextEditingController _resetPasswordController;
  late Function(String) _showSnackBar;

  UserModel(this._showSnackBar) {
    passwordVisibility = false;
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _cinController = TextEditingController();
    _dateDeDelivranceController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _statutController = TextEditingController();
    _passwordController = TextEditingController();
    _resetPasswordController = TextEditingController();
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

  Future<void> registerUser(BuildContext context) async {
    try {
      // Effectuez les validations sur les champs du formulaire
      if (_firstNameController.text.isEmpty ||
          _lastNameController.text.isEmpty ||
          _cinController.text.isEmpty ||
          _dateDeDelivranceController.text.isEmpty ||
          _emailController.text.isEmpty ||
          _phoneNumberController.text.isEmpty ||
          _statutController.text.isEmpty ||
          _passwordController.text.isEmpty ||
          _resetPasswordController.text.isEmpty) {
        throw Exception('Tous les champs doivent être remplis');
      }
      if (_passwordController.text != _resetPasswordController.text) {
        throw Exception('Les mots de passe doivent correspondre');
      }

      if (_cinController.text.length != 8) {
        throw Exception('Le numéro CIN doit contenir exactement 8 chiffres');
      }

      if (!isValidEmail(_emailController.text)) {
        throw Exception('Veuillez entrer une adresse email valide');
      }

      // Effectuez la requête HTTP d'inscription
      var url = Uri.parse('http://127.0.0.1:8000/users/register/');
      var headers = {'Content-Type': 'application/json'};
      var body = json.encode({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'cin': int.parse(_cinController.text),
        'dateDeDelivrance': _dateDeDelivranceController.text,
        'email': _emailController.text,
        'phoneNumber': int.parse(_phoneNumberController.text),
        'statut': _statutController.text,
        'password': _passwordController.text,
        'resetPassword': _resetPasswordController.text,
      });

      var response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // Traitement en cas de succès
        // Effacez les valeurs des champs après l'inscription
        _firstNameController.clear();
        _lastNameController.clear();
        _cinController.clear();
        _dateDeDelivranceController.clear();
        _emailController.clear();
        _phoneNumberController.clear();
        _statutController.clear();
        _passwordController.clear();
        _resetPasswordController.clear();

        // Affichez un message de succès si l'inscription réussit
        _showSnackBar('Inscription réussie');
      } else {
        // Traitement en cas d'erreur
        throw Exception('Erreur lors de l\'inscription: ${response.body}');
      }

      // Notifie les écouteurs du changement d'état
      notifyListeners();
    } catch (e) {
      // Affichez un SnackBar pour informer l'utilisateur de l'erreur
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

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un numéro de téléphone';
    }
    final isDigitsOnly = value.contains(RegExp(r'^[0-9]+$'));
    if (!isDigitsOnly) {
      return 'Le numéro de téléphone ne doit contenir que des chiffres';
    }
    if (value.length != 8) {
      return 'Le numéro de téléphone doit contenir exactement 8 chiffres';
    }
    return null;
  }

  // Validation d'une adresse email
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void showSnackBar(BuildContext context, String message) {
    var scaffoldKey;
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
