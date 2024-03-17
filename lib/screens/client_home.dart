import 'package:fixlit/screens/chat/chat_screen.dart';
import 'package:fixlit/screens/profile/client_profile.dart';
import 'package:fixlit/services/apis.dart';
import 'package:fixlit/utils/pallate.dart';
import 'package:fixlit/widgets/bottom_navigation.dart';
import 'package:fixlit/widgets/client_home/catagory_card.dart';
import 'package:fixlit/widgets/client_home/upper_catagory_header.dart';
import 'package:fixlit/widgets/client_home/main_header.dart';
import 'package:flutter/material.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  bool homeScreen = true;
  bool inboxScreen = false;
  bool profileScreen = false;

  @override
  void initState() {
    Services.clientProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            btn: false,
            isSearch: true,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 14,
              ),
              const UpperCatagoryHeader(),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: Text(
                      "Populer Projects :",
                      style: TextStyle(
                        fontSize: 20,
                        color: Clrs.mainColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CatagoryCard(
                        title: 'Plumbing',
                        image: 'assets/imgs/bg2.jpg',
                      ),
                      CatagoryCard(
                        title: 'Electrition',
                        image: 'assets/imgs/bg3.jpg',
                      ),
                      CatagoryCard(
                        title: 'Cleaning',
                        image: 'assets/imgs/bg1.jpg',
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
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

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatScreen(),
                    ),
                  );
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
