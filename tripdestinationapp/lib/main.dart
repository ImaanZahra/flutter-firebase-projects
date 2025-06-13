import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'login_signup.dart';
import 'home_page.dart'; // Extracted from your original TripHomePage

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(TripDestinationApp());
}

class TripDestinationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Trip Destination App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.dark().copyWith(
          primary: Colors.black,
          secondary: Color(0xFF00C853),
          surface: Colors.grey[900],
        ),
        iconTheme: IconThemeData(color: Colors.white),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.grey),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginSignupPage(),
        '/home': (context) => TripHomePage(),
      },
    );
  }
}