import 'package:flutter/material.dart';
import 'package:appp/components/UniversalButtonTwo.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'WartungPopUps.dart';

class UserStart extends StatefulWidget {
  const UserStart({Key? key}) : super(key: key);

  @override
  _UserStartState createState() => _UserStartState();
}

class _UserStartState extends State<UserStart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(19, 44, 89, 1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/images/pilz2.png',
              height: 36.0,
            ),
          ],
        ),
      ),
      body: const MyCardWidget(),
    );
  }
}

class MyCardWidget extends StatelessWidget {
  const MyCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            width: 430,
            height: 230,
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              color: const Color.fromRGBO(246, 241, 235, 1),
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ListTile(
                    leading: Image.asset(
                      'lib/images/pilz.jpg',
                      height: 36.0,
                    ),
                    title: const Text('',
                        style: TextStyle(fontSize: 30.0)),
                    subtitle: const Text('Leitung Kundenservice',
                        style: TextStyle(fontSize: 18.0)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.0),
                            child: UniversalButtonTwo(
                              buttonText: 'Anruf',
                              onPressed: () async {
                                launch('tel:');
                              },
                              textColor: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.0),
                            child: UniversalButtonTwo(
                              buttonText: 'Nachricht',
                              onPressed: () {
                                launch('mailto:');
                              },
                              textColor: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: () {
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
                                  'alles klar',
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    onPressed: () {
                                      showMyDialog(context);
                                    },
                                    child: const Text(
                                      'Weiter',
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
                },
                child: Card(
                  color: const Color.fromRGBO(246, 241, 235, 1),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Container(
                    width: 175,
                    height: 150,
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(
                      children: <Widget>[
                        const Positioned(
                          top: 0,
                          left: 5,
                          child: Text(
                            'Wartung',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Image.asset(
                            'lib/images/tools.png',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: const Color.fromRGBO(246, 241, 235, 1),
                          ),
                          width: 500,
                          height: 400,
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'Notdienst',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Color.fromRGBO(19, 44, 89, 1),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.',
                                          textAlign: TextAlign.justify,
                                        ),
                                        const SizedBox(height: 16.0),
                                        const Text(
                                          'Wenn sie Fortfahren, wird automatisch die Notdienst-Rufnummer gewählt!',
                                          textAlign: TextAlign.justify,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    onPressed: () {
                                      FlutterPhoneDirectCaller.callNumber(
                                          '+');
                                    },
                                    child: const Text(
                                      'Fortfahren',
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
                },
                child: Card(
                  color: const Color.fromRGBO(246, 241, 235, 1),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Container(
                    width: 175,
                    height: 150,
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(
                      children: <Widget>[
                        const Positioned(
                          top: 0,
                          left: 5,
                          child: Text(
                            'Notdienst',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Image.asset(
                            'lib/images/emergency.png',
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
