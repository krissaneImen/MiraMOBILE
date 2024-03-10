class User {
  final String firstName;
  final String lastName;
  final int cin;
  final DateTime dateDeDelivrance;
  final String email;
  final int phoneNumber;
  final String statut;
  final String password;
  final String resetPassword;

  User({
    required this.firstName,
    required this.lastName,
    required this.cin,
    required this.dateDeDelivrance,
    required this.email,
    required this.phoneNumber,
    required this.statut,
    required this.password,
    required this.resetPassword,
  });
}
