import 'package:fixlit/screens/client/chat/client_chat_screen.dart';
import 'package:fixlit/screens/service%20provider/profile/service_profile.dart';
import 'package:fixlit/screens/service%20provider/service_home.dart';
import 'package:fixlit/services/apis.dart';
import 'package:fixlit/utils/pallate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceBottomNavigationBar extends StatefulWidget {
  const ServiceBottomNavigationBar({super.key});

  @override
  State<ServiceBottomNavigationBar> createState() =>
      _ServiceBottomNavigationBarState();
}

class _ServiceBottomNavigationBarState
    extends State<ServiceBottomNavigationBar> {
  int myCurrentindex = 0;
  List pages = [
    const ServiceProviderHome(),
    const ClientChatScreen(),
    ServiceProfileScreen(user: Services.serviceProvider),
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
            backgroundColor: Clrs.mainColor,
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
