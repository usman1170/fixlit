import 'package:fixlit/auth/screens/forgotpass.dart';
import 'package:fixlit/auth/widgets/auth_dialogs.dart';
import 'package:fixlit/models/client_model.dart';
import 'package:fixlit/screens/chat/chat_screen.dart';
import 'package:fixlit/screens/client_home.dart';
import 'package:fixlit/screens/profile/client_edit.dart';
import 'package:fixlit/services/apis.dart';
import 'package:fixlit/utils/pallate.dart';
import 'package:fixlit/widgets/bottom_navigation.dart';
import 'package:fixlit/widgets/buttons.dart';
import 'package:flutter/material.dart';

class ClientProfileScreen extends StatefulWidget {
  const ClientProfileScreen({super.key, required this.user});
  final ClientModel user;

  @override
  State<ClientProfileScreen> createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen> {
  bool homeScreen = false;
  bool inboxScreen = false;
  bool profileScreen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        leading: const BackPopButton(
          bgcolor: Colors.blue,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                AuthDialogs().logOutDialog(context);
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            _topBuild(),
            const SizedBox(
              height: 18,
            ),
            _bottomBuild(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
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

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(),
                        ));
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
                  },
                  title: 'Profile',
                  icon: Icons.person,
                  color: profileScreen ? Colors.orange : Clrs.mainColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _topBuild() {
    final user = Services.client;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 160,
          width: 160,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(75),
            child: Image.network(
              user.image,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                }
              },
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.blue,
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          user.name == "" ? "Edit profile to add Name" : user.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          user.email,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            letterSpacing: .4,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _bottomBuild() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(60),
            // topRight: Radius.circular(60),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: ListView(
            children: [
              TileWidget(
                title: "Edit Profile",
                icon: Icons.arrow_forward_ios,
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ClientEditProfile(user: widget.user),
                    ),
                  );
                },
              ),
              TileWidget(
                title: "Settings",
                icon: Icons.arrow_forward_ios,
                ontap: () {},
              ),
              TileWidget(
                title: "Change Password",
                icon: Icons.arrow_forward_ios,
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen(),
                      ));
                },
              ),
              TileWidget(
                title: "LogOut",
                icon: Icons.arrow_forward_ios,
                ontap: () {
                  AuthDialogs().logOutDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TileWidget extends StatelessWidget {
  const TileWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.ontap,
  });
  final String title;
  final IconData icon;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          trailing: IconButton(
            onPressed: ontap,
            icon: Icon(icon),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Divider(
            indent: 10,
            endIndent: 10,
          ),
        ),
      ],
    );
  }
}
