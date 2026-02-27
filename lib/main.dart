import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:my_app/core/services/auth_session_storage.dart';
import 'package:my_app/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Firebase initialization failed: $e');
  }

  Widget initialScreen = const LoginPage();

  try {
    if (await AuthSessionStorage.isLoggedIn()) {
      final creds = await AuthSessionStorage.getCredentials();
      if (creds['email'] != null && creds['password'] != null) {
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: creds['email']!,
            password: creds['password']!,
          );
          initialScreen = const HomePage();
        } catch (e) {
          print('Auto-login failed: $e');
          await AuthSessionStorage.clearSession();
        }
      }
    }
  } catch (e) {
    print('Error checking login status: $e');
  }

  runApp(MyApp(initialScreen: initialScreen));
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;
  const MyApp({super.key, required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    print('MyApp build called');
    return MaterialApp(
      title: 'KUSOED App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigoAccent,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: initialScreen,
    );
  }
}
