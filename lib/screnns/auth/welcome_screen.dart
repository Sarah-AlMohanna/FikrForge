import 'package:flutter/material.dart';

import '../../commenwidget/button.dart';
import '../../commenwidget/textInput.dart';
import '../../configuration/theme.dart';
import '../../models/user_profile_model.dart';
import '../../provider/user_provider.dart';
import 'login_screen.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      // Navigator.pushReplacement(context, MyCustomRoute(builder: (BuildContext context) => const LoginScreen()));

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png" , scale: 4,),
            SizedBox(height: size_H(50),),
            Image.asset("assets/images/welcome_1.png" , scale: 6,),
            SizedBox(height: size_H(50),),
            // const CircularProgressIndicator(color: Color(0xff1c0fb8),),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: (300),
                  child: T9ButtonReverce(
                    onPressed: () async {
                      Navigator.pushReplacementNamed(context, '/login');

                    },
                    textContent: "Click to start",
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

