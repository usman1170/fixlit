// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixlit/auth/widgets/loading_screen.dart';
import 'package:fixlit/main.dart';
import 'package:fixlit/services/apis.dart';
import 'package:fixlit/widgets/dialogs.dart';
import 'package:fixlit/widgets/grey_text.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController controller = TextEditingController();
  late Color mycolor;
  late Size mq;
  bool isLoading = false;
  @override
  void initState() {
    controller;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mycolor = Colors.deepPurple.shade400;
    mq = MediaQuery.of(context).size;
    return isLoading
        ? const LoadingScreen()
        : GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: Container(
                      height: 38,
                      width: MediaQuery.of(context).size.width,
                      color: darkColor,
                    ),
                  ),
                  Positioned(
                    top: mq.height * .1,
                    child: _mainTopBuild(),
                  ),
                  Positioned(
                    bottom: 0,
                    child: _bottomBuild(),
                  ),
                ],
              ),
            ),
          );
  }

  Widget _mainTopBuild() {
    return Container(
      width: mq.width,
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            height: 110,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset('assets/icon/playstore.png'),
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            "FixLit Hub",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w700,
              shadows: [
                Shadow(
                  color: darkColor,
                  blurRadius: 8,
                  offset: Offset(1, 2),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _bottomBuild() {
    return SizedBox(
      width: mq.width,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8,
            ),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Welcome FixLit Hub",
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: darkColor,
              letterSpacing: .4),
        ),
        greyText("Forgot your password?"),
        SizedBox(
          height: mq.height * .03,
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            label: const Text(
              "Email",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
            prefixIcon: const Icon(Icons.email),
            hintText: "Enter Email",
            hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
            prefixIconColor: darkColor,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                borderSide: BorderSide(color: darkColor)),
            contentPadding: const EdgeInsets.only(
              top: 18,
              bottom: 18,
              left: 10,
            ),
          ),
        ),
        SizedBox(
          height: mq.height * .04,
        ),
        _resetButton(),
        SizedBox(
          height: mq.height * .03,
        ),
        Center(
          child: greyText("OR back to login screen"),
        ),
        SizedBox(
          height: mq.height * .03,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              backgroundColor: darkColor,
              elevation: 8,
              shadowColor: darkColor,
              minimumSize: const Size.fromHeight(55)),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                "Back",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
        SizedBox(
          height: mq.height * .03,
        ),
      ],
    );
  }

  Widget _resetButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: darkColor,
          elevation: 8,
          shadowColor: darkColor,
          minimumSize: const Size.fromHeight(55)),
      onPressed: () async {
        setState(() {
          isLoading = true;
        });
        try {
          await Services.auth
              .sendPasswordResetEmail(email: controller.text.toString())
              .then((value) {
            setState(() {
              isLoading = false;
            });

            Dialogs().errorDialog(context, 'Set Password',
                "Please check your mailbox to reset your password");
          });
        } on FirebaseAuthException catch (e) {
          // print("Error is ${e.code}");
          if (e.code == 'invalid-email') {
            setState(() {
              isLoading = false;
            });
            Dialogs().errorDialog(context, 'Error Occured',
                "Invalid Email entered. Please write correct Email");
          } else if (e.code == 'network-request-failed') {
            setState(() {
              isLoading = false;
            });
            Dialogs().errorDialog(context, 'Error Occured',
                "Bad Connection. Please check your internet");
          } else {
            setState(() {
              isLoading = false;
            });
            Dialogs()
                .errorDialog(context, 'Error Occured', "Something wents wrong");
          }
        }
        setState(() {
          isLoading = false;
        });
      },
      child: const Text(
        "Send Forgot Password Email",
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
