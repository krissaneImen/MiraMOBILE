import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onPressed;

  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white, // Personnalisez la couleur de fond
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black, // Personnalisez la couleur du titre
        ),
      ),
      content: Text(
        content,
        style: TextStyle(
          color: Colors.black, // Personnalisez la couleur du contenu
        ),
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            'OK',
            style: TextStyle(
              color: Colors.blue, // Personnalisez la couleur du texte du bouton
            ),
          ),
        ),
      ],
    );
  }
}
