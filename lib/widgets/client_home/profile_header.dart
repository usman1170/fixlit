// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  ProfileHeader({
    required this.isButton,
    super.key,
  });
  bool isButton = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isButton
            ? IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              )
            : const SizedBox(),
        Row(
          children: [
            SizedBox(
              width: isButton ? 8 : 20,
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
        ),
      ],
    );
  }
}
