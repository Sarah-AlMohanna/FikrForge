import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../commenwidget/MyDatePicker.dart';
import '../../commenwidget/myDropDownWidgetValidator.dart';
import '../../models/generalListFireBase.dart';
import '../../provider/dataProvider.dart';
import 'login_screen.dart';


import '../../commenwidget/button.dart';
import '../../commenwidget/textInput.dart';
import '../../configuration/theme.dart';
import '../../models/user_profile_model.dart';
import '../../provider/user_provider.dart';
import '../home/home_page.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}
class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  List<UserProfile> usersData = [] ;

  List<GeneralFireBaseList> countryList = [] ;
  GeneralFireBaseList? selectedCountry ;
  bool isHidden = false ;


  String? country;
  DateTime? birthDate;
  String? _accountType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      countryList.add(GeneralFireBaseList(id: "1" , name: "Saudi arabia"));
      await Provider.of<DataProvider>(context, listen: false).getUsersData(usersData);
      setState(() {});
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
          width: size_W(200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 16),

                Text("Welcome to our app", style: ourTextStyle(fontSize: 18 , fontWeight: FontWeight.bold)),
                const SizedBox(height: 32),

                Center(child: Image.asset("assets/images/logo.png"  , scale: 6,)),
                const SizedBox(height: 32),

                // Full Name
                Container(
                    padding:  EdgeInsets.only(right: size_W(15), left: size_W(15)),
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 0, bottom: 0),
                    child: Text("Full Name *", style: ourTextStyle(fontSize: 15))),
                const SizedBox(height: 5),
                T9EditTextStyle("", fullNameController),
                const SizedBox(height: 16),

                // Username
                Container(
                    padding:  EdgeInsets.only(right: size_W(15), left: size_W(15)),
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 0, bottom: 0),child: Text("Username *", style: ourTextStyle(fontSize: 15))),
                const SizedBox(height: 5),
                T9EditTextStyle("", usernameController),
                const SizedBox(height: 16),

                // Email
                Container(
                    padding:  EdgeInsets.only(right: size_W(15), left: size_W(15)) , margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 0, bottom: 0),child: Text("Email", style: ourTextStyle(fontSize: 15))),
                const SizedBox(height: 5),
                T9EditTextStyle("", emailController),
                const SizedBox(height: 16),

                // Phone Number
                Container(
                    padding:  EdgeInsets.only(right: size_W(15), left: size_W(15)), margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 0, bottom: 0),child: Text("Phone Number", style: ourTextStyle(fontSize: 15))),
                const SizedBox(height: 5),
                T9EditTextStyle("", phoneController),
                const SizedBox(height: 16),


                // Password
                Container(
                    padding:  EdgeInsets.only(right: size_W(15), left: size_W(15)), margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 0, bottom: 0),child: Text("Country/region", style: ourTextStyle(fontSize: 15))),
                const SizedBox(height: 5),
                MyDropDownWidgetValidator(
                  isRequired: true,
                  // controller: _country,
                  title: "Country",
                  selectedValue: selectedCountry,
                  listOfData: countryList,
                  validator: (value) {
                    if (value == null) {
                      return "Please enter your country";
                    }
                    return null;
                  },
                  callBack: (GeneralFireBaseList? newValue){
                    setState(() {
                      selectedCountry = newValue ;
                    });
                  },
                ),
                const SizedBox(height: 20),

                Container(
                    padding:  EdgeInsets.only(right: size_W(15), left: size_W(15)), margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 0, bottom: 0),child: Text("Birth date", style: ourTextStyle(fontSize: 15))),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: (){
                    MyDatePicker().selectDate(context , birthDate).then((value) {
                      if(value != null){
                        setState(() {
                          final DateFormat serverFormater = DateFormat('dd/MM/yyyy');
                          birthDateController.text = serverFormater.format(value);
                        });
                      }
                    });
                  },
                  child: T9EditTextStyle("" , isEnable: false ,birthDateController),
                ),
                const SizedBox(height: 16),

                // Password
                Container(
                    padding:  EdgeInsets.only(right: size_W(15), left: size_W(15)), margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 0, bottom: 0),child: Text("Password", style: ourTextStyle(fontSize: 15))),
                const SizedBox(height: 5),
                T9EditTextStylePassword("", passwordController,  isHidden: isHidden,
                    function: () {
                      setState(() {
                        isHidden = !isHidden;
                      });
                    }),
                const SizedBox(height: 20),

                // // Password
                // Text("identity number", style: ourTextStyle(fontSize: 15)),
                // const SizedBox(height: 5),
                // T9EditTextStyle("", identityNumberController, ),
                // const SizedBox(height: 20),
                //



                // USER TYPE
                Container(
                  padding:  EdgeInsets.only(right: size_W(15), left: size_W(15)), margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 0, bottom: 0),
                  width: (300),
                  child: const Text(
                    'Choose your account type:',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(
                  height: (10),
                ),

                Container(

                  padding:  EdgeInsets.only(right: size_W(15), left: size_W(15)), margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 0, bottom: 0),
                  width: (600),                  child: Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: Text('Entrepreneur' , style: ourTextStyle(),),
                          value: 'entrepreneur',
                          groupValue: _accountType,
                          onChanged: (String? value) {
                            setState(() {
                              _accountType = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: Text('Investor', style: ourTextStyle(),),
                          value: 'investor',
                          groupValue: _accountType,
                          onChanged: (String? value) {
                            setState(() {
                              _accountType = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),


                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: (300),
                      child: T9ButtonReverce(
                        onPressed: () async {
                        if(fullNameController.text.isEmpty){
                        EasyLoading.showError("Please add the full name");
                        return ;
                        }  else  if(usernameController.text.isEmpty){
                          EasyLoading.showError("Please add the user name");
                          return ;
                        } else  if(emailController.text.isEmpty){
                          EasyLoading.showError("Please add the email address");
                          return ;
                        } else   if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(emailController.text)) {
                          EasyLoading.showError('Please enter a valid email address');
                        }
                        else if (isEmailExists(email: emailController.text)) {
                          EasyLoading.showError("Email is exists!");
                        } else if (isUserNameExists(username: usernameController.text)) {
                          EasyLoading.showError("User name is exists!");
                        }  else if(selectedCountry == null) {
                          EasyLoading.showError("Please select country");
                        }  else  if(passwordController.text.isEmpty){
                          EasyLoading.showError("Please enter the password");
                        } else if (!RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$').hasMatch(passwordController.text)) {
                          EasyLoading.showError("Please enter a valid  password");
                        } else if(_accountType == null) {
                          EasyLoading.showError("Please select account type");
                        } else {

                          UserProfile userProfile = UserProfile(
                            fillName: fullNameController.text,
                            email: emailController.text,
                            phoneNumber: phoneController.text.isNotEmpty? phoneController.text : "",
                            birthDate: emailController.text,
                            countryId: '${selectedCountry!.id}',
                            password:  passwordController.text,
                            accountType: "$_accountType",
                            // companyRegistration: companyRegistrationController.text.isNotEmpty? companyRegistrationController.text : "",
                            // identityNumber: identityNumberController.text,
                            userId: "",
                            userName: usernameController.text,
                          );
                          Map<String, dynamic> userData = userProfile.toJson();

                            EasyLoading.show();
                            await Provider.of<UserProvider>(context , listen: false).registerUser(emailController.text , passwordController.text , userData ).then((value) {
                              if(value != null){
                                if(value == true){
                                  EasyLoading.showSuccess("Thanks for register in our app, You can login now");
                                  // RegisteredSuccessfullyPage
                                  // Navigator.push(context, MyCustomRoute(builder: (BuildContext context) => RegisteredSuccessfullyPage()));
                                  Navigator.of(context).pop();
                                  return;
                                } else{

                                  EasyLoading.showError("There is a problem , Please try again");
                                }
                              }
                            });




                        }


                        },
                        textContent: "Register",
                      ),
                    ),
                  ],
                ),


                const SizedBox(height: 20),
                // Navigation to Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                        Navigator.of(context).pop();

                      },
                      child: Text("Already have an account? Log in" , style: ourTextStyle(),),
                    ),
                  ],
                ),
                const SizedBox(
                  height: (10),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }


  bool isEmailExists({required String email}) {
    for (UserProfile user in usersData) {
      if (user.email == email) {
        return true;
      }
    }
    return false;
  }
  bool isUserNameExists({required String username}) {
    for (UserProfile user in usersData) {
      if (user.userName == username) {
        return true;
      }
    }
    return false;
  }

}
