// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

class BackPopButton extends StatelessWidget {
  const BackPopButton({
    super.key,
    required this.color,
    required this.bgcolor,
  });
  final Color color;

  final Color bgcolor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        padding: const EdgeInsets.only(left: 6),
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: bgcolor,
        ),
        child: Icon(
          Icons.arrow_back,
          color: color,
          size: 26,
        ),
      ),
    );
  }
}
