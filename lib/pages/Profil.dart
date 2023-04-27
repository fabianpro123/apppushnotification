import 'package:appp/pages/ProfilePages.dart/Account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:appp/pages/ProfilePages.dart/SicherheitPages.dart/Sicherheit.dart';
import 'package:appp/pages/ProfilePages.dart/Mitteilungen.dart';
import 'package:appp/pages/ProfilePages.dart/DarstellungFolder.dart/Darstellung.dart';
import 'package:url_launcher/url_launcher.dart';

class Profil extends StatefulWidget {
  Profil({Key? key}) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  late final User user;

  // sign user in method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  final Uri url = Uri.parse("https://g.page/r/CQbchXShwxuXEBM/review");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromRGBO(246, 241, 235, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(19, 44, 89, 1),
        title: const Text('Einstellungen'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'EINSTELLUNGEN',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: const Color.fromRGBO(19, 44, 89, 1),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.person, color: Colors.white),
                        title: const Text(
                          'Account',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: const Icon(Icons.keyboard_arrow_right,
                            color: Colors.white),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AccountPage(),
                            ),
                          );
                        },
                      ),
                      Container(
                        width: double.infinity,
                        height: 0.5,
                        color: Colors.grey.shade400,
                      ),
                      ListTile(
                        leading:
                            const Icon(Icons.security, color: Colors.white),
                        title: const Text(
                          'Sicherheit',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: const Icon(Icons.keyboard_arrow_right,
                            color: Colors.white),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Sicherheit(),
                            ),
                          );
                        },
                      ),
                      Container(
                        width: double.infinity,
                        height: 0.5,
                        color: Colors.grey.shade400,
                      ),
                      ListTile(
                        leading: const Icon(Icons.notifications,
                            color: Colors.white),
                        title: const Text(
                          'Mitteilungen',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: const Icon(Icons.keyboard_arrow_right,
                            color: Colors.white),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Mitteilungen(),
                            ),
                          );
                        },
                      ),
                      Container(
                        width: double.infinity,
                        height: 0.5,
                        color: Colors.grey.shade400,
                      ),
                      ListTile(
                        leading: const Icon(Icons.art_track_outlined,
                            color: Colors.white),
                        title: const Text(
                          'Darstellung',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: const Icon(Icons.keyboard_arrow_right,
                            color: Colors.white),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Darstellung(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ÜBER',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: const Color.fromRGBO(19, 44, 89, 1),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.star, color: Colors.white),
                        title: const Text(
                          'JÄHNKE bewerten',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: const Icon(Icons.keyboard_arrow_right,
                            color: Colors.white),
                        onTap: () {
                          launchUrl(url);
                        },
                      ),
                      Container(
                        width: double.infinity,
                        height: 0.5,
                        color: Colors.grey.shade400,
                      ),
                      ListTile(
                        leading:
                            const Icon(Icons.safety_check, color: Colors.white),
                        title: const Text(
                          'Datenschutz',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: const Icon(Icons.keyboard_arrow_right,
                            color: Colors.white),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Darstellung(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: const Color.fromRGBO(19, 44, 89, 1),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: const Text(
                          'Log Out',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        onTap: signUserOut,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
