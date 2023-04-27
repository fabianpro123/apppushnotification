import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class UserHeizung extends StatelessWidget {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String currentUserUid = FirebaseAuth.instance.currentUser?.uid ?? '';

  UserHeizung({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(19, 44, 89, 1),
        title: const Text('Mein Wärmeerzeuger'),
        centerTitle: true,
      ),
      floatingActionButton: null,
      body: FutureBuilder<DocumentSnapshot>(
        future: _db
            .collection('users')
            .where('uid', isEqualTo: currentUserUid)
            .get()
            .then((QuerySnapshot querySnapshot) {
          // Return the first document from the query snapshot
          return querySnapshot.docs.first;
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Fehler beim Laden der Daten'));
          } else {
            final data = snapshot.data!.data() as Map<String, dynamic>?;
            final modell = data?['Modell'] as String?;
            final wartungstermin = data?['Nächster Wartungstermin'] as String?;
            final Installationsdatum = data?['Installationsdatum'] as String?;
            final Heizungsart = data?['Heizungsart'] as String?;

            return SlidingUpPanel(
              minHeight: 80,
              maxHeight: 500,
              backdropEnabled: true, //darken background if panel is open
              color: Colors
                  .transparent, //necessary if you have rounded corners for panel
              /// panel itself
              panel: Container(
                decoration: const BoxDecoration(
                  // background color of panel
                  color: Color.fromRGBO(246, 241, 235, 1),
                  // rounded corners of panel
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const BarIndicator(),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "Meine  $Heizungsart",
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Modell: $modell",
                            style: const TextStyle(fontSize: 15),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Wartungstermin: $wartungstermin",
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// widget behind panel
              body: const Center(
                child: Text(
                  "This is the Widget behind the sliding panel",
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class BarIndicator extends StatelessWidget {
  const BarIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: 40,
        height: 3,
        decoration: const BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
