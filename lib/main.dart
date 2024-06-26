import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fixlit/auth/screens/login.dart';
import 'package:fixlit/auth/screens/veify.dart';
import 'package:fixlit/firebase_options.dart';
import 'package:fixlit/routes.dart';
import 'package:fixlit/screens/splash.dart';
import 'package:fixlit/screens/user_decider.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

late Size mq;
const Color darkColor = Color(0xFF2C2C2C);
const Color yellowColor = Color(0xFFF9AA33);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FixLit Hub',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: darkColor,
        ),
        useMaterial3: true,
      ),
      routes: {
        loginroute: (context) => const LoginScreen(),
      },
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class BuilderScreen extends StatefulWidget {
  const BuilderScreen({super.key});

  @override
  State<BuilderScreen> createState() => _BuilderScreenState();
}

class _BuilderScreenState extends State<BuilderScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          if (user.emailVerified) {
            return const UserDeciderScreen();
          } else {
            return const NewVerifyView();
          }
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
