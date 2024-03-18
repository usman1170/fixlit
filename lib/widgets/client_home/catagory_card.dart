import 'package:fixlit/screens/client/catagory_card_result.dart';
import 'package:flutter/material.dart';

class CatagoryCard extends StatelessWidget {
  const CatagoryCard({
    super.key,
    required this.title,
    required this.image,
  });
  final String title;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchedCatagory(
                image: image,
                catagory: title,
              ),
            ),
          );
        },
        child: Card(
          elevation: 4,
          child: Container(
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
                  style: const TextStyle(
                    fontSize: 16,
                    letterSpacing: .2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 9,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
