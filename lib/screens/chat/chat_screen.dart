import 'package:fixlit/screens/client_home.dart';
import 'package:fixlit/screens/profile/client_profile.dart';
import 'package:fixlit/services/apis.dart';
import 'package:fixlit/utils/pallate.dart';
import 'package:fixlit/widgets/bottom_navigation.dart';
import 'package:fixlit/widgets/client_home/main_header.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool homeScreen = false;
  bool inboxScreen = true;
  bool profileScreen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(btn: true, isSearch: false),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          height: 62,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Clrs.mainColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BottomSheetButton(
                ontap: () {
                  setState(() {
                    homeScreen = true;
                    inboxScreen = false;
                    profileScreen = false;
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ClientHomeScreen(),
                    ),
                  );
                },
                title: 'Home',
                icon: Icons.home,
                color: homeScreen ? Colors.orange : Clrs.mainColor,
              ),
              BottomSheetButton(
                ontap: () {
                  setState(() {
                    homeScreen = false;
                    inboxScreen = true;
                    profileScreen = false;
                  });
                },
                title: 'Inbox',
                icon: Icons.inbox,
                color: inboxScreen ? Colors.orange : Clrs.mainColor,
              ),
              BottomSheetButton(
                ontap: () {
                  setState(() {
                    homeScreen = false;
                    inboxScreen = false;
                    profileScreen = true;
                  });

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ClientProfileScreen(user: Services.client),
                      ));
                },
                title: 'Profile',
                icon: Icons.person,
                color: profileScreen ? Colors.orange : Clrs.mainColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
