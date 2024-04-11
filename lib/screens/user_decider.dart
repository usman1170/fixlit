// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixlit/auth/screens/login.dart';
import 'package:fixlit/auth/widgets/loading_screen.dart';
import 'package:fixlit/screens/client/client_bottom_navigation_bar.dart';
import 'package:fixlit/screens/service%20provider/service_bottom_bar.dart';
import 'package:flutter/material.dart';

class UserDeciderScreen extends StatefulWidget {
  const UserDeciderScreen({super.key});

  @override
  State<UserDeciderScreen> createState() => _UserDeciderScreenState();
}

class _UserDeciderScreenState extends State<UserDeciderScreen> {
  final user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<String> getUser() async {
    try {
      final snapshot = await firestore.collection("users").doc(user!.uid).get();
      final role = snapshot.data()?["role"];
      print("My role is -- $role");
      return role;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUser(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const LoadingScreen();
          case ConnectionState.active:
          case ConnectionState.done:
            final role = snapshot.data;
            // print("========================");
            // print("snapshot role ${snapshot.data}");
            // print("========================");
            if (role == "client" && role != null) {
              return const ClientBottomNavigationBar();
            } else if (role == "serviceProvider" && role != null) {
              return const ServiceBottomNavigationBar();
            } else {
              return const LoginScreen();
            }
          default:
            return const LoginScreen();
        }
      },
    );
  }
}
