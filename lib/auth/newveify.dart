// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixlit/auth/newlogin.dart';
import 'package:fixlit/widgets/dialogs.dart';
import 'package:fixlit/widgets/grey_text.dart';
import 'package:flutter/material.dart';

class NewVerifyView extends StatefulWidget {
  const NewVerifyView({super.key});

  @override
  State<NewVerifyView> createState() => _NewVerifyViewState();
}

class _NewVerifyViewState extends State<NewVerifyView> {
  late Color mycolor;
  late Size mq;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    mycolor = Colors.deepPurple.shade400;
    mq = MediaQuery.of(context).size;
    return isLoading
        ? Container(
            decoration: BoxDecoration(
              color: mycolor,
              image: const DecorationImage(
                image: AssetImage("assets/imgs/bg3.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: const Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage('assets/icon/playstore.png'),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Please wait...',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              color: mycolor,
              image: const DecorationImage(
                image: AssetImage("assets/imgs/bg3.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
                  children: [
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
                Shadow(color: Colors.blue, blurRadius: 8, offset: Offset(1, 2))
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
              color: Colors.blue,
              letterSpacing: .4),
        ),
        greyText("Please Verify yourself"),
        SizedBox(
          height: mq.height * .03,
        ),
        Container(
          height: mq.height * .15,
          width: mq.width,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "We have sent you email for verification, if you didn't found email please check your spam folder",
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              letterSpacing: .4,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          height: mq.height * .03,
        ),
        _loginButton(),
        SizedBox(
          height: mq.height * .025,
        ),
        Center(
          child: greyText("OR back to login screen"),
        ),
        SizedBox(
          height: mq.height * .025,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              backgroundColor: Colors.blue,
              elevation: 8,
              shadowColor: Colors.blue,
              minimumSize: const Size.fromHeight(55)),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const NewLoginScreen(),
              ),
            );
          },
          child: const Text(
            "Back to Login Screen",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          height: mq.height * .02,
        ),
      ],
    );
  }

  Widget _loginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: Colors.blue,
          elevation: 8,
          shadowColor: Colors.blue,
          minimumSize: const Size.fromHeight(55)),
      onPressed: () async {
        setState(() {
          isLoading = true;
        });
        final user = FirebaseAuth.instance.currentUser;
        await user!.sendEmailVerification().then((value) {
          Dialogs().errorDialog(context, 'Error Occured',
              "Please check your mail box and verify yourself");
        });
        setState(() {
          isLoading = false;
        });
      },
      child: const Text(
        "Send Email Veification",
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
