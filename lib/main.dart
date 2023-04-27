import 'package:appp/pages/ProfilePages.dart/DarstellungFolder.dart/preferences_bloc.dart';
import 'package:appp/pages/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appp/pages/ProfilePages.dart/DarstellungFolder.dart/preferences.dart';
import 'package:appp/pages/ProfilePages.dart/DarstellungFolder.dart/preferences_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Firebase Cloud Messaging initialisieren
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String currentUserUid = FirebaseAuth.instance.currentUser?.uid ?? '';
  String? token = await messaging.getToken();

  if (token != null) {
    QuerySnapshot querySnapshot = await _db
        .collection('users')
        .where('uid', isEqualTo: currentUserUid)
        .get();

    if (querySnapshot.size == 1) {
      String documentId = querySnapshot.docs.first.id;
      DocumentReference userDoc = _db.collection('users').doc(documentId);
      userDoc.set({
        'fcmToken': token,
      }, SetOptions(merge: true));
    }
  }

  // Push-Benachrichtigungen initialisieren
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Received message: ${message.notification?.title}');
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Message clicked!');
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("onResume: $message");
  });

  // Push-Benachrichtigungsberechtigung anfordern
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PreferencesCubit>(
      future: buildBloc(),
      builder: (context, blocSnapshot) {
        if (blocSnapshot.hasData && blocSnapshot.data != null) {
          return BlocProvider<PreferencesCubit>(
            create: (_) => blocSnapshot.data!,
            child: BlocBuilder<PreferencesCubit, Preferences>(
              builder: (context, preferences) {
                return MaterialApp(
                  theme: ThemeData.light().copyWith(
                    scaffoldBackgroundColor:
                        const Color.fromRGBO(246, 241, 235, 1),
                  ),
                  darkTheme: ThemeData.dark().copyWith(
                    scaffoldBackgroundColor: Colors.grey[900],
                    buttonTheme: ButtonThemeData(
                      buttonColor: const Color.fromRGBO(255, 292, 203, 1),
                    ),
                    appBarTheme: const AppBarTheme(
                      color: Color.fromRGBO(255, 292, 203, 1),
                    ),
                  ),
                  themeMode: preferences.themeMode,
                  debugShowCheckedModeBanner: false,
                  home: const AuthPage(),
                );
              },
            ),
          );
        } else {
          return Container(); // return an empty container while waiting for data
        }
      },
    );
  }

  Future<PreferencesCubit> buildBloc() async {
    final prefs = await SharedPreferences.getInstance();
    final service = MyPreferencesService(prefs);
    return PreferencesCubit(service, service.get());
  }
}
