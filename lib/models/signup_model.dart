import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:mira/screens/login.dart';
import 'package:mira/screens/signup.dart';
import 'package:http/http.dart' as http;

class signupModel extends FlutterFlowModel<SignupPage> {
  // Define the properties
  String selectedStatus = ''; // Default value can be empty string
  List<String> statusList = [
    'Etudiant',
    'Enseignant',
    'Administratif'
  ]; // Add your status options

  ///  State fields for stateful widgets in this page.
  TextEditingController? dateController;
  String? Function(BuildContext, String?)? dateValidator;
  final unfocusNode = FocusNode();
  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameController;
  String? Function(BuildContext, String?)? nameControllerValidator;
  // State field(s) for firstname widget.
  FocusNode? fisrtnameFocusNode;
  TextEditingController? firstnameController;
  String? Function(BuildContext, String?)? firstnameControllerValidator;
  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressController;
  String? Function(BuildContext, String?)? emailAddressControllerValidator;
  // State field(s) for cin widget.
  FocusNode? cinFocusNode;
  TextEditingController? cinController;
  String? Function(BuildContext, String?)? cinControllerValidator;
  // State field(s) for date widget.
  FocusNode? datecinFocusNode;
  TextEditingController? datecinController;
  String? Function(BuildContext, String?)? datecinControllerValidator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordControllerValidator;
  //CONFIRM PASSWORD
  FocusNode? confirmPasswordFocusNode;
  TextEditingController? confirmPasswordController;
  String? Function(BuildContext, String?)? confirmPasswordControllerValidator;
//telephone
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberController;
  String? Function(BuildContext, String?)? phoneNumberControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    passwordVisibility = false;
    dateController = TextEditingController();
  }

  void dispose() {
    unfocusNode.dispose();
    nameFocusNode?.dispose();
    nameController?.dispose();

    fisrtnameFocusNode?.dispose();
    firstnameController?.dispose();

    emailAddressFocusNode?.dispose();
    emailAddressController?.dispose();

    cinFocusNode?.dispose();
    cinController?.dispose();

    datecinFocusNode?.dispose();
    datecinController?.dispose();

    passwordFocusNode?.dispose();
    passwordController?.dispose();
    dateController?.dispose();
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Veuillez entrer votre adresse e-mail';
    }

    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(email)) {
      return 'Veuillez entrer une adresse e-mail valide';
    }

    return null; // L'e-mail est valide
  }

  Future<void> registerUser(BuildContext context) async {
    if (_validateInputs()) {
      final String apiUrl = 'http://127.0.0.1:8000/users/register/';
      try {
        final response = await http.post(Uri.parse(apiUrl), body: {
          "cin": cinController!.text,
          "phone_number": phoneNumberController!.text,
          "email": emailAddressController!.text,
          "password": passwordController!.text,
          "first_name": nameController!.text,
          "last_name": firstnameController!.text,
          "date_de_delivrance": datecinController!.text,
          "statut": selectedStatus!,
        });

        if (response.statusCode == 200) {
          print('Utilisateur enregistré avec succès');
          // Redirection vers la page de connexion
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('Erreur lors de l\'enregistrement de l\'utilisateur.'),
            ),
          );
        }
      } catch (e) {
        print('Erreur lors de la requête HTTP: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur de connexion.'),
          ),
        );
      }
    }
  }

  bool _validateInputs() {
    if (cinController!.text.isEmpty) {
      print('Le champ CIN est vide.');
      return false;
    }

    if (cinController!.text.length != 8 ||
        !cinController!.text.contains(RegExp(r'^[0-9]+$'))) {
      print('Le format du CIN est incorrect.');
      return false;
    }

    if (phoneNumberController!.text.isEmpty) {
      print('Le champ de numéro de téléphone est vide.');
      return false;
    }

    if (emailAddressController!.text.isEmpty) {
      print('Le champ d\'adresse e-mail est vide.');
      return false;
    }

    // Valider l'adresse e-mail avec la fonction de validation fournie
    String? emailError = validateEmail(emailAddressController!.text);
    if (emailError != null) {
      print(emailError);
      return false;
    }

    if (passwordController!.text.isEmpty) {
      print('Le champ de mot de passe est vide.');
      return false;
    }

    if (passwordController!.text.length < 6) {
      print('Le mot de passe doit contenir au moins 6 caractères.');
      return false;
    }

    if (confirmPasswordController!.text != passwordController!.text) {
      print('Les mots de passe ne correspondent pas.');
      return false;
    }

    if (nameController!.text.isEmpty) {
      print('Le champ de nom est vide.');
      return false;
    }

    if (firstnameController!.text.isEmpty) {
      print('Le champ de prénom est vide.');
      return false;
    }

    if (datecinController!.text.isEmpty) {
      print('Le champ de date de délivrance de la CIN est vide.');
      return false;
    }

    // Si toutes les validations passent, retourne true
    return true;
  }
}
