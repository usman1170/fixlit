import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade100,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          children: [
            Text(
              "Good Morning!",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade100,
              ),
            ),
            Text(
              "Usman Ghani",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade100,
                letterSpacing: .4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        )
      ],
    );
  }
}
