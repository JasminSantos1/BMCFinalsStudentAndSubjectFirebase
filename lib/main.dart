import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'page_form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    const creamBackground = Color(0xFFFFF9EE);
    const primaryPeach = Color(0xFFFF8B52);
    const cardSurface = Color(0xFFFFFFFF);
    const borderOutline = Color(0xFFFFD1B3);
    const textDark = Color(0xFF4A3E3D);

    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );

    return MaterialApp(
      title: 'Cute Enrollment App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: creamBackground,
        colorScheme: const ColorScheme.light(
          primary: primaryPeach,
          onPrimary: Colors.white,
          surface: cardSurface,
          background: creamBackground,
        ),
        textTheme: ThemeData.light().textTheme.apply(
              bodyColor: textDark,
              displayColor: textDark,
            ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          labelStyle: const TextStyle(color: Color(0xFF9E8B88)),
          floatingLabelStyle: const TextStyle(color: primaryPeach, fontWeight: FontWeight.bold),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: borderOutline, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: primaryPeach, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.redAccent, width: 2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryPeach,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(50),
            elevation: 2,
            shape: buttonShape,
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryPeach,
            side: const BorderSide(color: primaryPeach, width: 2),
            minimumSize: const Size.fromHeight(50),
            shape: buttonShape,
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
      home: const UserRegistrationScreen(),
    );
  }
}