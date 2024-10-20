import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:forgeapp/screnns/auth/register_screen.dart';
import 'package:provider/provider.dart';

import '../../commenwidget/button.dart';
import '../../commenwidget/textInput.dart';
import '../../configuration/theme.dart';
import '../../models/user_profile_model.dart';
import '../../provider/user_provider.dart';
import '../home/home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userOrEmailController = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isHidden = true ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
                  children: [

      Expanded(child: Image.asset("assets/images/logo.png"  , scale: 6,)),

      Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size_W(200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding:  EdgeInsets.only(right: size_W(15), left: size_W(15)),
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, top: 0, bottom: 0),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Email",
                            style: ourTextStyle(fontSize: 15),
                          ),
                        )),
                    T9EditTextStyle(
                      "",
                      userOrEmailController,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: (16),
              ),
              Container(
                width: size_W(200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding:  EdgeInsets.only(right: size_W(15), left: size_W(15)),
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, top: 0, bottom: 0),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Password",
                            style: ourTextStyle(fontSize: 15),
                          ),
                        )),
                    T9EditTextStylePassword("", password, isHidden: isHidden,
                        function: () {
                      setState(() {
                        isHidden = !isHidden;
                      });
                    }),
                  ],
                ),
              ),
              const SizedBox(
                height: (20),
              ),
          
              Container(
                width: size_W(180),
                child: InkWell(
                  onTap: (){
                    // Navigator.push(context, MyCustomRoute(builder: (BuildContext context) => const RegistrationScreen()));
                    // Navigator.pushNamed(context, '/registration');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Forget Password", style: ourTextStyle(fontWeight: FontWeight.w600 , fontSize: 15),),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: (20),
              ),
          
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: (300),
                  child: T9ButtonReverce(
                    onPressed: () async {

                      if(kDebugMode){
                        userOrEmailController.text = "user@user.com";
                        password.text = "User#1234";
                      }

                      try {
                        if(userOrEmailController.text.isEmpty){
                          EasyLoading.showError("Enter email");
                          return ;
                        } else if(password.text.isEmpty){
                          EasyLoading.showError("Enter password");
                          return ;
                        }
                        ///
                        // EasyLoading.show();
                        // UserCredential userCredential = await Provider.of<UserProvider>(context , listen: false).loginUser(userOrEmailController.text, password.text);
                        // if(userCredential.user != null){
                        //   print("Login successful! User ID: ${userCredential.user!.uid}");
                        //   // Map<String, dynamic>? userData = await getUserData(userCredential.user!.uid);
                        //   Map<String, dynamic>? userData = await Provider.of<UserProvider>(context , listen: false).getUserData(userCredential.user!.uid);
                        //   if(userData != null){
                        //     EasyLoading.dismiss();
                        //
                        //     if(userData["account_type"] == "entrepreneur"){
                        //       /// entrepreneur
                        //       if(kDebugMode){
                        //         Navigator.pushNamed(context, '/homePageEntrepreneur');
                        //       } else {
                        //         Navigator.pushReplacementNamed(context, '/homePageEntrepreneur');
                        //       }
                        //     } else {
                        //       Navigator.pushReplacementNamed(context, '/homePage');
                        //     }
                        //
                        //
                        //   } else {
                        //     EasyLoading.dismiss();
                        //     EasyLoading.showError("Login failed");
                        //   }
                        //
                        // }
                        ///
                        await Provider.of<UserProvider>(context , listen: false).loginUserBase(context, userOrEmailController.text, password.text);

                      } catch (e) {
                        EasyLoading.dismiss();
                        EasyLoading.showError("Login failed");
                        print("Login failed: $e");
                      }
                    },
                    textContent: "Login",
                  ),
                ),
              ),
              const SizedBox(
                height: (10),
              ),
          
          
          
              Container(
                width: size_W(180),
                child: InkWell(
                  onTap: (){
                    // Navigator.push(context, MyCustomRoute(builder: (BuildContext context) => const RegistrationScreen()));
                    Navigator.pushNamed(context, '/registration');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${"If you don't have an account,"} " , style: ourTextStyle(fontSize: 15),),
                        Text("Register now", style: ourTextStyle(fontWeight: FontWeight.w600 , fontSize: 15),),
                      ],
                    ),
                  ),
                ),
              ),
          
              const SizedBox(
                height: (10),
              ),
          
          
            ],
          ),
        ),
      ),
                  ],
                ),
    );
  }
}
