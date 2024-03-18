import 'package:fixlit/screens/chat/chat_screen.dart';
import 'package:fixlit/screens/client_home.dart';
import 'package:fixlit/screens/profile/client_profile.dart';
import 'package:fixlit/services/apis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int myCurrentindex = 0;
  List pages = [
    const ClientHomeScreen(),
    const ChatScreen(),
    ClientProfileScreen(user: Services.client),
  ];
  @override
  void initState() {
    Services.getMyProfile();
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
            color: Colors.blue.withOpacity(.27),
          )
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            selectedItemColor: Colors.blue.shade700,
            unselectedItemColor: Colors.black54,
            currentIndex: myCurrentindex,
            onTap: (value) {
              setState(() {
                myCurrentindex = value;
              });
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
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
