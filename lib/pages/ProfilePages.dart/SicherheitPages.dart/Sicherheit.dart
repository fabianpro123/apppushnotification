import 'package:appp/pages/LogInPages.dart/ForgotPassword.dart';
import 'package:flutter/material.dart';
import 'package:appp/components/UniversalButton.dart';
import '../../../components/UniversalButton4.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class Sicherheit extends StatefulWidget {
  const Sicherheit({Key? key}) : super(key: key);

  @override
  _SicherheitState createState() => _SicherheitState();
}

class _SicherheitState extends State<Sicherheit> {
  bool _showConfirmationDialog = false;

  void _showDeleteConfirmationDialog() {
    setState(() {
      _showConfirmationDialog = true;
    });
  }

  void _closeDeleteConfirmationDialog() {
    setState(() {
      _showConfirmationDialog = false;
    });
  }

  Future<void> _deleteCurrentUserAndData(BuildContext context) async {
    try {
      // Schritt 1: KDN des aktuellen Benutzers herausfinden
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('Benutzer ist nicht angemeldet.');
        return;
      }

      QuerySnapshot userDocs = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: user.uid)
          .get();

      if (userDocs.docs.isEmpty) {
        print('Benutzerdaten nicht gefunden.');
        return;
      }

      DocumentSnapshot userDoc = userDocs.docs.first;
      String kdnValue = userDoc['KDN'];
      print(kdnValue);

      // Schritt 2: Ordner im Storage löschen
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference userFolderRef = storage.ref().child('files').child(kdnValue);
      await userFolderRef.delete();

      // Schritt 3: Dokument des Benutzers in der Firestore-Datenbank löschen
      await userDoc.reference.delete();

      // Schritt 4: Account des Benutzers löschen
      await user.delete();

      Navigator.of(context).pushReplacementNamed('/login');

      // Erfolgsnachricht anzeigen
      print('Benutzerdaten und Konto wurden erfolgreich gelöscht.');
    } catch (error) {
      print('Fehler beim Löschen der Benutzerdaten und des Kontos: $error');
    }
  }

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
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 30),
              // Add other widgets here as needed
              UniversalButton(
                iconData: Icons.security,
                buttonText: 'Passwort ändern',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResetPasswordPage()),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Add other widgets here as needed
              UniversalButton4(
                buttonText: 'Konto löschen',
                onPressed: _showDeleteConfirmationDialog,
              ),
            ],
          ),
          if (_showConfirmationDialog)
            Container(
              color: Colors.black
                  .withOpacity(0.4), // Halbtransparenter Hintergrund
              child: Center(
                child: CupertinoAlertDialog(
                  title: Text('Konto löschen'),
                  content: Text('Möchten Sie Ihr Konto wirklich löschen?'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text('Abbrechen'),
                      onPressed: _closeDeleteConfirmationDialog,
                    ),
                    CupertinoDialogAction(
                      child: Text('Löschen'),
                      onPressed: () {
                        _deleteCurrentUserAndData(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
