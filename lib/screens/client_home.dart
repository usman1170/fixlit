import 'package:fixlit/services/apis.dart';
import 'package:fixlit/utils/pallate.dart';
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
              const BottomSheetButton(
                title: 'Home',
                icon: Icons.home,
                color: Colors.orange,
              ),
              BottomSheetButton(
                title: 'Inbox',
                icon: Icons.inbox,
                color: Clrs.mainColor,
              ),
              BottomSheetButton(
                title: 'Profile',
                icon: Icons.person,
                color: Clrs.mainColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomSheetButton extends StatelessWidget {
  const BottomSheetButton({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });
  final String title;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 100,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 26,
              width: 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: color,
              ),
              child: Icon(
                icon,
                size: 22,
                color: Colors.white,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
