import 'package:appp/pages/StartPages.dart/Start.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:appp/pages/Heizung.dart';
import 'package:appp/pages/Profil.dart';
import 'package:appp/pages/Dokumente.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  final user = FirebaseAuth.instance.currentUser!;

  @override
  _HomePageState createState() => _HomePageState();

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    UserStart(),
    UserHeizung(),
    const UserDokumente(),
    Profil(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color.fromRGBO(246, 241, 235, 1),
            currentIndex: _selectedIndex,
            selectedItemColor: const Color.fromRGBO(19, 44, 89, 1),
            unselectedItemColor: Colors.grey.withOpacity(0.7),
            elevation: 0,
            onTap: _navigateBottomBar,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ' Start'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.heat_pump_rounded), label: 'Heizung'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.document_scanner_rounded),
                  label: 'Dokumente'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Einstellungen'),
            ]));
  }
}
