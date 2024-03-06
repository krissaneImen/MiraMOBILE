import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String nom;
  final String prenom;
  final int cin; // Changement de type de long à int
  final DateTime datecin; // Changement de type de date de long à DateTime
  final String email;
  final int phoneNumber;
  final String mdp;
  final String type;
  final String token;
  final List<dynamic> cart;

  const User({
    required this.id,
    required this.nom,
    required this.prenom, // Ajout de virgule manquante
    required this.email,
    required this.cin,
    required this.datecin,
    required this.phoneNumber,
    required this.mdp,
    required this.type,
    required this.token,
    required this.cart,
  });

  @override
  List<Object?> get props => [id, mdp];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom, // Correction de la clé 'name' à 'nom'
      'prenom': prenom, // Ajout de clé 'prenom'
      'email': email,
      'cin': cin, // Correction de la clé 'password' à 'cin'
      'datecin': datecin.toIso8601String(), // Conversion de DateTime en String
      'mdp': mdp,
      'phoneNumber': phoneNumber,
      'type': type,
      'token': token,
      'cart': cart,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      nom: map['name'] ?? '',
      prenom: map['prenom'] ?? '',
      email: map['email'] ?? '',
      cin: map['cin'] ?? 0,
      datecin: DateTime.parse(map['datecin'] ?? ''),
      phoneNumber: (map['phoneNumber']),
      mdp: map['mdp'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      cart: List<dynamic>.from(map['cart'] ?? []),
    );
  }

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
