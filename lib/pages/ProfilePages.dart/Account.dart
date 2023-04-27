import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../components/UniversalButtonTwo.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  String _name = '';
  String _email = '';
  String _address = '';
  String _phone = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    final user = _auth.currentUser;
    final userData = await _db
        .collection('users')
        .where('uid', isEqualTo: user!.uid)
        .get()
        .then((value) => value.docs.first.data());
    setState(() {
      _name = userData['Name'];
      _email = userData['Email'];
      _address = userData['Straße mit Hausnummer'];
      _phone = userData['Telefonnummer'];
      _nameController = TextEditingController(text: _name);
      _emailController = TextEditingController(text: _email);
      _addressController = TextEditingController(text: _address);
      _phoneController = TextEditingController(text: _phone);
    });
  }

  void _updateUserData() async {
    final user = _auth.currentUser;
    final userData = await _db
        .collection('users')
        .where('uid', isEqualTo: user!.uid)
        .get()
        .then((value) => value.docs.first);
    await _db.collection('users').doc(userData.id).update({
      'Name': _name,
      'Email': _email,
      'Straße mit Hausnummer': _address,
      'Telefonnummer': _phone,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(19, 44, 89, 1),
        centerTitle: true,
        title: const Text('Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                onSaved: (value) => _name = value!,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                onSaved: (value) => _email = value!,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                onSaved: (value) => _address = value!,
                decoration: InputDecoration(
                  labelText: 'Addresse',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              IntlPhoneField(
                controller: _phoneController,
                onSaved: (PhoneNumber? value) => _phone = value!.completeNumber,
                decoration: const InputDecoration(
                    labelText: "Telefonnummer",
                    border: OutlineInputBorder(borderSide: BorderSide())),
              ),
              const SizedBox(height: 16),
              UniversalButtonTwo(
                buttonText: 'Anwenden',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _updateUserData();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
