import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDokumente extends StatefulWidget {
  const UserDokumente({Key? key}) : super(key: key);

  @override
  _UserDokumenteState createState() => _UserDokumenteState();
}

class _UserDokumenteState extends State<UserDokumente> {
  late String _kdn;
  List<String> _offerFiles = [];
  List<String> _orderFiles = [];
  List<String> _invoiceFiles = [];

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: user.uid)
          .get();
      if (userData.docs.isNotEmpty) {
        final kdn = userData.docs.first.get('KDN');
        setState(() {
          _kdn = kdn;
        });
        await _getFiles();
      }
    }
  }

  Future<void> _getFiles() async {
    final storage = FirebaseStorage.instance;
    final offerFolder = storage.ref('files/$_kdn/Angebot');
    final orderFolder = storage.ref('files/$_kdn/Auftrag');
    final invoiceFolder = storage.ref('files/$_kdn/Rechnung');

    final offerFiles = await offerFolder.listAll();
    _offerFiles = offerFiles.items.map((item) => item.name).toList();

    final orderFiles = await orderFolder.listAll();
    _orderFiles = orderFiles.items.map((item) => item.name).toList();

    final invoiceFiles = await invoiceFolder.listAll();
    _invoiceFiles = invoiceFiles.items.map((item) => item.name).toList();

    setState(() {});
  }

  Future<void> _openPdf(String folderName, String fileName) async {
    final storage = FirebaseStorage.instance;
    final ref = storage.ref('files/$_kdn/$folderName/$fileName');
    final url = await ref.getDownloadURL();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Scaffold(
                  appBar: AppBar(
                    backgroundColor: const Color.fromRGBO(19, 44, 89, 1),
                    title: const Text('PDF Viewer'),
                  ),
                  body: SfPdfViewer.network(
                    url,
                    canShowScrollHead: false,
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () => _downloadPdf(url, fileName),
                    tooltip: 'PDF herunterladen',
                    child: const Icon(Icons.download),
                  ),
                )));
  }

  Future<void> _downloadPdf(String url, String fileName) async {
    final response = await get(Uri.parse(url));
    final documentDirectory = await getApplicationDocumentsDirectory();
    final file = File('${documentDirectory.path}/$fileName.pdf');
    await file.writeAsBytes(response.bodyBytes);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF erfolgreich heruntergeladen')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(19, 44, 89, 1),
        title: const Text('Meine Dokumente'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (_offerFiles.isNotEmpty) ...[
            Text(
              'Angebote:',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _offerFiles.length,
              itemBuilder: (context, index) {
                final fileName = _offerFiles[index];
                return ListTile(
                  title: Text(fileName),
                  onTap: () => _openPdf('Angebot', fileName),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
          if (_orderFiles.isNotEmpty) ...[
            Text(
              'Aufträge:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _orderFiles.length,
              itemBuilder: (context, index) {
                final fileName = _orderFiles[index];
                return ListTile(
                  title: Text(fileName),
                  onTap: () => _openPdf('Auftrag', fileName),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
          if (_invoiceFiles.isNotEmpty) ...[
            Text(
              'Rechnungen:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _invoiceFiles.length,
              itemBuilder: (context, index) {
                final fileName = _invoiceFiles[index];
                return ListTile(
                  title: Text(fileName),
                  onTap: () => _openPdf('Rechnung', fileName),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
          if (_offerFiles.isEmpty &&
              _orderFiles.isEmpty &&
              _invoiceFiles.isEmpty)
            const Center(
              child: Text('Keine Dokumente vorhanden'),
            ),
        ],
      ),
    );
  }
}
