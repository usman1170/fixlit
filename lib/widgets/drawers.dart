import 'package:fixlit/screens/profile/profile.dart';
import 'package:fixlit/services/apis.dart';
import 'package:fixlit/widgets/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.blue,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 12, left: 8),
          child: ListView(
            children: [
              const SizedBox(
                height: 18,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  "FixLit",
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.black45,
                indent: 6,
                endIndent: 20,
              ),
              TileWidget(
                icon: const Icon(
                  CupertinoIcons.home,
                  color: Colors.white,
                ),
                title: "Home",
                ontap: () {
                  Navigator.of(context).pop();
                },
              ),
              TileWidget(
                icon: const Icon(
                  CupertinoIcons.settings,
                  color: Colors.white,
                ),
                title: "Settings",
                ontap: () {
                  Navigator.of(context).pop();
                },
              ),
              TileWidget(
                icon: const Icon(
                  CupertinoIcons.profile_circled,
                  color: Colors.white,
                ),
                title: "Profile",
                ontap: () {
                  Navigator.of(context).pop();
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (_) => ProfileScreen(
                  //         user: Services.me,
                  //       ),
                  //     ));
                },
              ),
              const Divider(
                color: Colors.black45,
                indent: 6,
                endIndent: 20,
              ),
              TileWidget(
                icon: const Icon(
                  CupertinoIcons.info,
                  color: Colors.white,
                ),
                title: "About Us",
                ontap: () {
                  Navigator.of(context).pop();
                },
              ),
              TileWidget(
                icon: const Icon(
                  CupertinoIcons.command,
                  color: Colors.white,
                ),
                title: "FeedBack",
                ontap: () {
                  Navigator.of(context).pop();
                },
              ),
              const Divider(
                color: Colors.black45,
                indent: 6,
                endIndent: 20,
              ),
              TileWidget(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                title: "LogOut",
                ontap: () {
                  Dialogs().logOutDialog(context);
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
  final Icon icon;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: ListTile(
        leading: icon,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
