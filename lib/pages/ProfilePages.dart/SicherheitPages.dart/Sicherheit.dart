import 'package:flutter/material.dart';
import 'package:appp/components/UniversalButton.dart';
import 'Re-Passwort.dart';

class Sicherheit extends StatelessWidget {
  const Sicherheit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 241, 235, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(19, 44, 89, 1),
        title: const Text('Sicherheit'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          // Add other widgets here as needed
          UniversalButton(
            iconData: Icons.security,
            buttonText: 'Passwort ändern',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Passwort()),
              );
            },
          ),
        ],
      ),
    );
  }
}
