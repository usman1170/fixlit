// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixlit/auth/screens/forgotpass.dart';
import 'package:fixlit/auth/screens/signup.dart';
import 'package:fixlit/auth/widgets/loading_screen.dart';
import 'package:fixlit/main.dart';
import 'package:fixlit/widgets/dialogs.dart';
import 'package:fixlit/widgets/grey_text.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Color mycolor;
  late Size mq;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = false;
  bool obscure = true;

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
    mycolor = darkColor;
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
              image: DecorationImage(
                image: AssetImage("assets/icon/playstore.png"),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            "FixLit Hub",
            style: TextStyle(
              color: darkColor,
              fontSize: 28,
              fontWeight: FontWeight.w700,
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
              color: darkColor,
              letterSpacing: .4),
        ),
        greyText("Please Enter your Login info"),
        SizedBox(
          height: mq.height * .03,
        ),
        _inputField(_email),
        SizedBox(
          height: mq.height * .032,
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
        _termConditions(),
        SizedBox(
          height: mq.height * .025,
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
        suffixIcon: isPassword
            ? InkWell(
                onTap: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
                child: const Icon(
                  Icons.remove_red_eye,
                  color: darkColor,
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
          backgroundColor: darkColor,
          elevation: 8,
          shadowColor: darkColor,
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

  Widget _termConditions() {
    return const Center(
      child: SizedBox(
        width: 250,
        child: Center(
          child: Column(children: [
            Text.rich(
              TextSpan(children: [
                TextSpan(
                  text: "By logging in it means you have agreed to our  ",
                  style: TextStyle(color: Colors.black54),
                ),
                TextSpan(
                  text: "Terms and Conditions",
                  style:
                      TextStyle(color: darkColor, fontWeight: FontWeight.w500),
                )
              ]),
              textAlign: TextAlign.center,
            ),
          ]),
        ),
      ),
    );
  }
}
