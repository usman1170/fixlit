import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixlit/routes.dart';
import 'package:flutter/material.dart';

class AuthDialogs {
  Future<void> logOutDialog(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('LogOut?'),
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 25, bottom: 12, right: 20),
            child: Text(
              "Are you sure You want to\nLogOut",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 110),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 12,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cencel'),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut().then(
                          (value) => Navigator.pushNamedAndRemoveUntil(
                              context, loginroute, (route) => false),
                        );
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
