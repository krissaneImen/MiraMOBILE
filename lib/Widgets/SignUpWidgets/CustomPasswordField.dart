import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final List<String> autofillHints;

  const CustomPasswordField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.autofillHints,
  }) : super(key: key);

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _isObscured = true;
  bool _isPasswordStrong = false;
  String? _password;
  String? _confirmPassword;
  bool _passwordsMatch = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: widget.controller,
            autofillHints: widget.autofillHints,
            obscureText: _isObscured,
            onChanged: (password) {
              setState(() {
                _password = password;
                _isPasswordStrong = _isStrongPassword(password);
              });
            },
            decoration: InputDecoration(
              labelText: widget.labelText,
              labelStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                    fontFamily: 'Plus Jakarta Sans',
                    color: Color(0xFF57636C),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFF1F4F8),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF4B39EF),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFE0E3E7),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Color(0xFFF1F4F8),
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
                focusNode: FocusNode(skipTraversal: true),
                child: Icon(
                  _isObscured
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Color(0xFF57636C),
                  size: 24,
                ),
              ),
              errorMaxLines:
                  3, // Permet d'afficher plusieurs lignes pour le message d'erreur
              errorText: _password != null && !_isPasswordStrong
                  ? 'Votre mot de passe doit contenir au moins 8 caractères avec des lettres majuscules, minuscules, des chiffres et des caractères spéciaux.'
                  : null,
            ),
          ),
          SizedBox(height: 8), // Ajoute un espacement vertical entre les champs
          if (_password != null && _password!.isNotEmpty)
            TextFormField(
              onChanged: (confirmPassword) {
                setState(() {
                  _confirmPassword = confirmPassword;
                  _passwordsMatch = _password == _confirmPassword;
                });
              },
              obscureText: _isObscured,
              decoration: InputDecoration(
                labelText: 'Confirmer le mot de passe',
                labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF57636C),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFF1F4F8),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF4B39EF),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFE0E3E7),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Color(0xFFF1F4F8),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                  focusNode: FocusNode(skipTraversal: true),
                  child: Icon(
                    _isObscured
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Color(0xFF57636C),
                    size: 24,
                  ),
                ),
                errorText: !_passwordsMatch
                    ? 'Les deux mots de passe ne correspondent pas.'
                    : null,
              ),
            ),
        ],
      ),
    );
  }

  bool _isStrongPassword(String password) {
    // Votre logique de validation du mot de passe ici
    // Par exemple, vérifiez la longueur du mot de passe et d'autres critères
    // Cette logique est un exemple simple. Vous pouvez personnaliser selon vos besoins.
    final minLength = 8;
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasDigits = password.contains(RegExp(r'[0-9]'));
    final hasSpecialCharacters =
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>-]'));

    return password.length >= minLength &&
        hasUppercase &&
        hasLowercase &&
        hasDigits &&
        hasSpecialCharacters;
  }
}
