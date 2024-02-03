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

class Button extends StatelessWidget {
  Button({
    required this.text,
    required this.color,
    required this.ontap,
    super.key,
  });
  final VoidCallback ontap;
  String text;
  Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 55,
        width: MediaQuery.of(context).size.width - 20,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                letterSpacing: 0.7,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}

class NewButton extends StatelessWidget {
  const NewButton({super.key, required this.ontap, required this.title});
  final VoidCallback ontap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: Colors.amber,
        elevation: 8,
        shadowColor: Colors.amber,
        minimumSize: const Size.fromHeight(55),
      ),
      onPressed: ontap,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
