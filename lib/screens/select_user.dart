import 'package:fixlit/auth/screens/login.dart';
import 'package:fixlit/main.dart';
import 'package:fixlit/services/apis.dart';
import 'package:fixlit/utils/pallate.dart';
import 'package:fixlit/widgets/grey_text.dart';
import 'package:flutter/material.dart';

class SelectUserScreen extends StatefulWidget {
  const SelectUserScreen({super.key});

  @override
  State<SelectUserScreen> createState() => _SelectUserScreenState();
}

class _SelectUserScreenState extends State<SelectUserScreen> {
  late Color mycolor;
  String userType = "";

  void selectUserType(String type) {
    setState(() {
      userType = type;
      Services.me.role = userType;
    });
    print(userType);
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    mycolor = Colors.blue.shade400;
    return Container(
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
                top: mq.height * .2,
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
            height: mq.height * .18,
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
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
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
                        greyText("Please Select User type and Continue"),
                        SizedBox(
                          height: mq.height * .025,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () => selectUserType('client'),
                      child: Container(
                        height: 42,
                        width: 105,
                        decoration: BoxDecoration(
                          color: userType == 'client' ? Colors.blue : null,
                          border: Border.all(
                            color: userType == 'client'
                                ? Colors.white
                                : Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            'Client',
                            style: TextStyle(
                              color: userType == 'client'
                                  ? Colors.white
                                  : Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => selectUserType('serviceProvider'),
                      child: Container(
                        height: 42,
                        width: 180,
                        decoration: BoxDecoration(
                          color: userType == 'serviceProvider'
                              ? Colors.blue
                              : null,
                          border: Border.all(
                            color: userType == 'serviceProvider'
                                ? Colors.white
                                : Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            'Service Provider',
                            style: TextStyle(
                              color: userType == 'serviceProvider'
                                  ? Colors.white
                                  : Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(
                            // serviceProvider: user,
                            ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    height: 52,
                    width: MediaQuery.of(context).size.width * .6,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Clrs.mainColor,
                        Colors.blue.shade600,
                      ]),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Continue to Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
