import 'package:flutter/material.dart';

class CatagoryCard extends StatelessWidget {
  const CatagoryCard({super.key, required this.title, required this.image});
  final String title;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 185,
      width: 140,
      margin: const EdgeInsets.only(right: 13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade100,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 145,
            width: 140,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              letterSpacing: .2,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
