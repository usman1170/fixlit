import 'package:fixlit/main.dart';
import 'package:fixlit/screens/client/chat/client_inbox.dart';
import 'package:fixlit/screens/client/profile/client_profile.dart';
import 'package:fixlit/screens/client/client_home.dart';
import 'package:fixlit/services/apis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClientBottomNavigationBar extends StatefulWidget {
  const ClientBottomNavigationBar({super.key});

  @override
  State<ClientBottomNavigationBar> createState() =>
      _ClientBottomNavigationBarState();
}

class _ClientBottomNavigationBarState extends State<ClientBottomNavigationBar> {
  int myCurrentindex = 0;
  List pages = [
    const ClientHomeScreen(),
    const ClientInbox(),
    ClientProfileScreen(user: Services.client),
  ];
  @override
  void initState() {
    Services.clientProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 8),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            blurRadius: 25,
            color: Colors.black54.withOpacity(.3),
          )
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            backgroundColor: darkColor,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            currentIndex: myCurrentindex,
            selectedIconTheme: const IconThemeData(
              color: Colors.orange,
              size: 26,
            ),
            onTap: (value) {
              setState(() {
                myCurrentindex = value;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.chat_bubble), label: "Inbox"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ],
          ),
        ),
      ),
      body: pages[myCurrentindex],
    );
  }
}
