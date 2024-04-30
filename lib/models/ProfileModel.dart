import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ProfileModel {
  Future<void> updateProfile({
    required String cin,
    required String email,
    required String phoneNumber,
    required String nom,
    required String prenom,
    required DateTime dateDelivrance,
    required String prenomArabe,
    required String nomArabe,
    required String nationalite,
    required String gouvernerat,
    required String delegation,
    required String lieuNaissanceArabe,
    required String adresseArabe,
    required String delegationArabe,
    required String genre,
    required String etatCivil,
    required DateTime dateNaissance,
    required String lieuNaissance,
    required String adresse,
    required String codePostal,
    required String image,
  }) async {
    String apiUrl = 'http://172.16.26.185:8000/profil/update/$cin/';

    try {
      var response = await http.put(
        Uri.parse(apiUrl),
        body: {
          'lieuNaissanceArabe': lieuNaissanceArabe,
          'prenom_arabe': prenomArabe,
          'nomArabe': nomArabe,
          'cartCin': cin,
          'email': email,
          'phoneNumber': phoneNumber,
          'firstName': nom,
          'lastName': prenom,
          'dateDeDelivrance': DateFormat('yyyy-MM-dd').format(dateDelivrance),
          'nationalite': nationalite,
          'gouvernerat': gouvernerat,
          'delegation': delegation,
          'adresseArabe': adresseArabe,
          'delegationArabe': delegationArabe,
          'genre': genre,
          'etatCivil': etatCivil,
          'dateNaissance': DateFormat('yyyy-MM-dd').format(dateNaissance),
          'lieuNaissance': lieuNaissance,
          'codePostal': codePostal,
          'image': image,
        },
      );

      if (response.statusCode == 200) {
        print('Profil mis à jour avec succès');
      } else {
        print(
            'Erreur lors de la mise à jour du profil: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur lors de la mise à jour du profil: $e');
    }
  }
}
