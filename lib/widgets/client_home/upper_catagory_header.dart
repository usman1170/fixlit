import 'package:fixlit/main.dart';
import 'package:fixlit/screens/client/all_catagory_page.dart';
import 'package:fixlit/screens/client/catagory_card_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpperCatagoryHeader extends StatefulWidget {
  const UpperCatagoryHeader({super.key});

  @override
  State<UpperCatagoryHeader> createState() => _UpperCatagoryHeaderState();
}

class _UpperCatagoryHeaderState extends State<UpperCatagoryHeader> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 10,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Browse by Catagory",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: darkColor,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SeeAllCatagoryScreen(),
                        ));
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    child: Text(
                      "See all",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.orange.shade700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CatagoryWidget(
                title: "Painting",
                icon: Icons.brush,
              ),
              CatagoryWidget(
                title: "Electrician",
                icon: Icons.flash_on,
              ),
              CatagoryWidget(
                title: "Driver",
                icon: CupertinoIcons.car_detailed,
              ),
              CatagoryWidget(
                title: "Plumbing",
                icon: Icons.plumbing,
              ),
              CatagoryWidget(
                title: "Cleaning",
                icon: Icons.cleaning_services,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CatagoryWidget extends StatelessWidget {
  const CatagoryWidget({
    super.key,
    required this.title,
    required this.icon,
  });
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchedCatagory(catagory: title),
                ));
          },
          child: Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.orange.shade600),
            ),
            child: Center(
              child: Icon(icon),
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          title,
          style: const TextStyle(
            color: darkColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
