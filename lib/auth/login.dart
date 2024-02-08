// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixlit/auth/forgotpass.dart';
import 'package:fixlit/auth/signup.dart';
import 'package:fixlit/main.dart';
import 'package:fixlit/screens/user_home.dart';
import 'package:fixlit/widgets/dialogs.dart';
import 'package:fixlit/widgets/grey_text.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  late Color mycolor;
  late Size mq;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = false;
  bool obscure = true;
  Future<UserCredential?> _signWithGoogle() async {
    try {
      setState(() {
        isLoading = true;
      });
      await InternetAddress.lookup("google.com");
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      setState(() {
        isLoading = false;
      });
      return await FirebaseAuth.instance.signInWithCredential(credentials);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Dialogs().errorDialog(
        context,
        'Error Occured',
        "Somrthing wents wrong (check internet)",
      );
    }
    setState(() {
      isLoading = false;
    });
    return null;
  }

  @override
  void initState() {
    _email;
    _password;
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mycolor = Colors.blue.shade400;
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
                      top: mq.height * .08,
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
          "Welcome",
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: Colors.blue,
              letterSpacing: .4),
        ),
        greyText("Please Enter your Login info"),
        SizedBox(
          height: mq.height * .03,
        ),
        _inputField(_email),
        SizedBox(
          height: mq.height * .035,
        ),
        _inputField(_password, isPassword: true),
        SizedBox(
          height: mq.height * .025,
        ),
        _forgotpass(),
        SizedBox(
          height: mq.height * .025,
        ),
        _loginButton(),
        SizedBox(
          height: mq.height * .025,
        ),
        _otherLogin(),
        SizedBox(
          height: mq.height * .02,
        ),
      ],
    );
  }

  Widget _inputField(TextEditingController controller, {isPassword = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? obscure : false,
      decoration: InputDecoration(
        label: Text(
          isPassword ? "Password" : "Email",
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
        prefixIcon:
            isPassword ? const Icon(Icons.lock) : const Icon(Icons.email),
        hintText: isPassword ? "Enter password" : "Enter Email",
        hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
        prefixIconColor: Colors.blue,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            borderSide: BorderSide(color: Colors.blue)),
        contentPadding: const EdgeInsets.only(
          top: 18,
          bottom: 18,
          left: 10,
        ),
        suffixIcon: isPassword
            ? InkWell(
                onTap: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
                child: const Icon(
                  Icons.remove_red_eye,
                  color: Colors.blue,
                ),
              )
            : const SizedBox(),
      ),
    );
  }

  Widget _forgotpass() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserSignUpScreen(
                    user: 'user',
                  ),
                ),
              );
            },
            child: greyText("Cerate account?"),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ForgotPasswordScreen(),
                ),
              );
            },
            child: greyText("Forgot my Password?"),
          )
        ],
      ),
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
        try {
          await auth
              .signInWithEmailAndPassword(
            email: _email.text.toString(),
            password: _password.text.toString(),
          )
              .then((value) {
            setState(() {
              isLoading = false;
            });
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const BuilderScreen(),
                ));
          });
        } on FirebaseAuthException catch (e) {
          // print("Error is ${e.code}");
          if (e.code == 'user-not-found') {
            setState(() {
              isLoading = false;
            });
            Dialogs().errorDialog(context, 'Error Occured', "User not Found");
          } else if (e.code == 'invalid-credential') {
            setState(() {
              isLoading = false;
            });
            Dialogs().errorDialog(context, 'Error Occured',
                "Wrong credential entered. Please check your email or password");
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
      },
      child: const Text(
        "Login",
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _otherLogin() {
    return Center(
      child: Column(
        children: [
          greyText("Or login with"),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  try {
                    _signWithGoogle().then((value) async {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserHomeScreen(),
                        ),
                      );
                    });
                  } catch (e) {
                    setState(() {
                      isLoading = false;
                    });
                    Dialogs().errorDialog(
                      context,
                      'Error Occured',
                      "Something wents wrong",
                    );
                  }
                },
                child: Container(
                  height: 55,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset("assets/imgs/g.png"),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 55,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset("assets/imgs/f.png"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
