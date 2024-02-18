// validators.dart

// Définir une fonction de validation pour le champ CIN
String? validateCIN(String? value) {
  if (value == null || value.isEmpty) {
    return 'Le champ CIN est requis';
  }
  if (value.length != 8) {
    return 'Le CIN doit contenir exactement 8 chiffres';
  }
  if (!value.contains(RegExp(r'^[0-9]*$'))) {
    return 'Le CIN doit contenir uniquement des chiffres';
  }
  return null; // La validation a réussi
}
