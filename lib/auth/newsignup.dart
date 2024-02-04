// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixlit/auth/newlogin.dart';
import 'package:fixlit/auth/newveify.dart';
import 'package:fixlit/models/user_model.dart';
import 'package:fixlit/services/apis.dart';
import 'package:fixlit/widgets/dialogs.dart';
import 'package:fixlit/widgets/grey_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewSignUpScreen extends StatefulWidget {
  const NewSignUpScreen({super.key});

  @override
  State<NewSignUpScreen> createState() => _NewSignUpScreenState();
}

class _NewSignUpScreenState extends State<NewSignUpScreen> {
  late Color mycolor;
  late Size mq;

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
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
    mycolor = Theme.of(context).primaryColor;
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
            "FamiCare",
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
          "Welcome, Sign Up",
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: Colors.blue,
              letterSpacing: .4),
        ),
        greyText("Please Enter your Email and password"),
        SizedBox(
          height: mq.height * .03,
        ),
        _inputField(_name, isName: true),
        SizedBox(
          height: mq.height * .035,
        ),
        _inputField(_email),
        SizedBox(
          height: mq.height * .035,
        ),
        _inputField(_password, isPassword: true),
        SizedBox(
          height: mq.height * .03,
        ),
        _signupButton(),
        SizedBox(
          height: mq.height * .03,
        ),
        InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const NewLoginScreen(),
              ),
            );
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have account? ",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                " Login",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: mq.height * .025,
        ),
      ],
    );
  }

  Widget _inputField(TextEditingController controller,
      {isPassword = false, isName = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? obscure : false,
      decoration: InputDecoration(
        label: Text(
          isPassword
              ? "Password"
              : isName
                  ? "Name"
                  : "Email",
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
        prefixIcon: isPassword
            ? const Icon(Icons.lock)
            : isName
                ? const Icon(CupertinoIcons.profile_circled)
                : const Icon(Icons.email),
        hintText: isPassword
            ? "Enter password"
            : isName
                ? "Enter Name"
                : "Enter Email",
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
                ))
            : const SizedBox(),
      ),
    );
  }

  Widget _signupButton() {
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
        if (_name.text != "") {
          print("ok");
          try {
            await auth
                .createUserWithEmailAndPassword(
              email: _email.text.toString(),
              password: _password.text.toString(),
            )
                .then((value) async {
              final user = FirebaseAuth.instance.currentUser;
              final date = DateTime.now().toString();
              final pUser = MainUser(
                name: _name.text.toString(),
                id: user!.uid,
                email: _email.text.toString(),
                createdAt: date,
                image: user.photoURL.toString(),
              );
              await Services.firestore
                  .collection("p_user")
                  .doc(user.uid)
                  .set(
                    pUser.toJson(),
                  )
                  .then((value) => {
                        setState(() {
                          isLoading = false;
                        }),
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewVerifyView(),
                          ),
                        ),
                      });
            });
          } on FirebaseAuthException catch (e) {
            print("Error is $e.code}");
            if (e.code == 'email-already-in-use') {
              setState(() {
                isLoading = false;
              });
              Dialogs().errorDialog(
                  context, 'Error Occured', "Email Already in use");
            } else if (e.code == 'weak-password') {
              setState(() {
                isLoading = false;
              });
              Dialogs().errorDialog(context, 'Error Occured',
                  "Password must contained 6 letters");
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
              Dialogs().errorDialog(
                  context, 'Error Occured', "Something wents wrong");
            }
          }
        } else {
          Dialogs().errorDialog(
              context, 'Error Occured', "Please Enter your name above");
        }
      },
      child: const Text(
        "Sign Up",
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
