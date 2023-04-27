import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

String phoneNumber = '';

Future<void> showMyDialog(BuildContext context) async {
  final user = FirebaseAuth.instance.currentUser;
  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('uid', isEqualTo: user!.uid)
      .get();
  if (snapshot.docs.isNotEmpty) {
    var phoneNumber = snapshot.docs.first.get('Telefonnummer');
    var Name = snapshot.docs.first.get('Name');
    var Heizungsart = snapshot.docs.first.get('Heizungsart');
    var Installationsdatum = snapshot.docs.first.get('Installationsdatum');
    var Ort = snapshot.docs.first.get('Ort');
    var Strasse = snapshot.docs.first.get('Straße mit Hausnummer');

    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: const Color.fromRGBO(246, 241, 235, 1),
            ),
            width: 550,
            height: 450,
            child: Column(
              children: [
                const Expanded(
                  child: Text(
                    'Hier ist der Inhalt des Pop-up-Fensters.',
                  ),
                ),
                Container(
                  width: 260, // Breite des Containers festlegen
                  child: IntlPhoneField(
                    decoration: const InputDecoration(
                      labelText: "Telefonnummer",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialValue: phoneNumber,
                    onChanged: (phone) {
                      phoneNumber = phone.completeNumber;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Abbrechen',
                        style: TextStyle(
                          color: Color.fromRGBO(19, 44, 89, 1),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final apiKey =
                            '';
                        final url = Uri.parse(
                            '');
                        final headers = {
                          'Content-Type': 'application/json',
                          'api-key': apiKey,
                        };
                        final body = jsonEncode({
                          'sender': {
                            'email': '',
                            'name': 'Wartungstermin-Bot'
                          },
                          'to': [
                            {
                              'email': '
                              'name': ''
                            }
                          ],
                          'subject': 'Wartungstermin',
                          'htmlContent': '<html><body><p>Moin,</p></body></html>'
                              '<html><body><p>$Name hätte gerne einen Wartungstermin für folgendes Gerät: $Heizungsart.</p></body></html>'
                              '<html><body><p></p></body></html>'
                              '<html><body><p>Bitte anrufen: $phoneNumber </p></body></html>'
                              '<html><body><p></p></body></html>'
                              '<html><body><p>Ort: $Ort </p></body></html>'
                              '<html><body><p>Straße: $Strasse  </p></body></html>'
                              '<html><body><p>Installatonsdatum: $Installationsdatum </p></body></html>'
                        });
                        final response = await http.post(
                          url,
                          headers: headers,
                          body: body,
                        );
                        if (response.statusCode == 201) {
                          print('Email sent successfully!');
                        } else {
                          print('Failed to send email: ${response.body}');
                        }
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Senden',
                        style: TextStyle(
                          color: Color.fromRGBO(19, 44, 89, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
