import 'dart:typed_data';
// import 'package:cool_alert/cool_alert.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/provider.dart';
import 'package:forgeapp/configuration/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class Theme_Information {


  // String currency = "SAR" ;

  static Color Primary_Color  = Color(0xff1c0fb8) ;
  // static Color Primary_Color  = Color(0xff654acb); // like blue


  // static Color Primary_Color  = Color(0xffe08f7e);
  static Color Second_Color  = Color(0xff10053e);  // like blue
  // static Color Second_Color  = Color(0xffca39a2);  // like pink
  // static Color Second_Color  = Color(0xff3d4156);
  static Color Thirsd_Color  = Color(0xffCABAED);

  static Color Button_Color  = Color(0xff5D81DE);
  static Color Button_Color2  = Color(0xff439CB8);






  // static Color BackGround_Color  = Color(0xff112b5c);
  // static Color BackGround_Color  = Color(0xff081a2f);
  // static Color Icon_Back_Color  = Color(0xff081a2f);
  // static Color Icon_Back_Color  = Color(0xff203043);
  // 




  static Color Box_Color = Color(0xff597fd5) ;
  static Color Box_Color2 = Color(0xff469abd) ;
  static Color Color_13 = Color(0xffffd100) ;
  // static Color Second_Color = Color.fromRGBO(84,86,91, 1.00) ;


  static Color? Color_1  = Colors.white ;
  static Color? Color_2  = Colors.white10 ;
  static Color? Color_3  = Colors.white30 ;
  static Color? Color_4  = Colors.white70 ;
  static Color? Color_44  = Colors.white70.withOpacity(0) ;
  static Color? Color_5  = Colors.black ;
  static Color? Color_6  = Colors.black38 ;

  static Color? Color_7  = Colors.grey ;
  static Color? Color_8  = Colors.grey[500] ;
  static Color? Color_9  = Colors.grey[200] ;
  static Color? Color_99  = Colors.grey.withOpacity(100) ;
  static Color? Color_10  = Colors.red ;
  static Color? Color_11  = Colors.red[200] ;
  static Color? Color_12  = Colors.green[500] ;

  static String? ENGfont = 'Montserrat' ;
  static String? ARfont = "ElMessiri" ;




  static BoxDecoration getBoxDecoration({Color? color, double? radius, Border? border, Gradient? gradient}) {
    return BoxDecoration(
      color: color ?? Color_1,
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
      boxShadow: [
        BoxShadow(color: Color_1!.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 5)),
      ],
      border: border ?? Border.all(color: Color_1!.withOpacity(0.05)),
      gradient: gradient,
    );
  }


  static Widget method_to_refresh_unlistview({required Widget Mywidget }) {
    return Stack(
      children: <Widget>[ListView(), Mywidget],
    );
  }
}

String getProductPriceWithTax({required String price,required String tax}){
  try{
    double priceD = double.parse(price) ;
    double taxD = double.parse(tax) ;
    double total = priceD + (priceD * (taxD/100));
    return "${total}";
  }catch(e){
    return " - " ;
  }
}



Future<dynamic> showErrorAlert(String error ) {
  return   EasyLoading.showError(error);
  // return CoolAlert.show(
  //   context: context,
  //   type: CoolAlertType.error,
  //   title: "Error".trn(),
  //   text: error,
  // );
}


Widget method_to_refresh_unlistview({required Widget child }) {
return Stack(
children: <Widget>[ListView(shrinkWrap: true), child],
);
}
Widget makeCalls({required String mobile}){
  return    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Center(
        child: Text(
            "$mobile",overflow: TextOverflow.ellipsis ,style: TextStyle(fontSize:  size_H(16.0) ),
            ),
      ),
      makeCall(phoneNumber: "$mobile")
    ],
  );
}

Widget makeCallsInCard(isMobile, {required String mobile}){
  return    Padding(
    padding: const EdgeInsets.all(0.0),
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
            "${isMobile? "Mobile: " : "Phone Number: "} $mobile",
           overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: size_H(16.0))),
        makeCall(phoneNumber: "$mobile")
      ],
    ),
  );
}

Widget makeCall({required String phoneNumber}) {
return  MaterialButton(
  minWidth: 1,
  padding: const EdgeInsets.all(0.0),
  onPressed: () {
    launch("tel://$phoneNumber") ;
  },textColor: Colors.blueAccent,
  child: Icon(Icons.call_outlined ,size: size_H(16.0),
    // overflow: TextOverflow.ellipsis ,style: TextStyle(fontSize: size_H(18.0)),
  ),
  // child: Text("Call" , overflow: TextOverflow.ellipsis ,style: TextStyle(fontSize: size_H(18.0)),),
);
}


Widget makeEmails({required String email}){
  return    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Center(
        child: Text(
            "$email",
           overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: size_H(16.0))),
      ),
      emailSend(email: "$email")
    ],
  );
}


String getInitials(String bankAccountName) => bankAccountName.isNotEmpty
    ? bankAccountName.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join(" ").toUpperCase()
    : '';

Widget makeEmailsInCard({required String email}){
  return    Padding(
    padding: const EdgeInsets.all(0.0),
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
            "Email: $email",
           overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: size_H(16.0))),
        emailSend(email: "$email")
      ],
    ),
  );
}

Widget emailSend({required String email }) {
  return  MaterialButton(
    minWidth: 1,
    padding: const EdgeInsets.all(0.0),
    onPressed: () {
      launch( 'mailto:$email');
    },textColor: Colors.blueAccent,
    child: Icon(Icons.email
      ,size: size_H(16.0),
      // overflow: TextOverflow.ellipsis ,style: TextStyle(fontSize: size_H(18.0)),
    ),
    // child: Text("Call" , overflow: TextOverflow.ellipsis ,style: TextStyle(fontSize: size_H(18.0)),),
  );
}

Widget makeWebsite({required String url}){
  return    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Center(
        child: Text(
            "$url", 
           overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: size_H(16.0))),
      ),
      websiteSend(oururl: "$url")
    ],
  );
}

Widget makeWebsiteInCard({required String url}){
  return    Padding(
    padding: const EdgeInsets.all(0.0),
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: size_W(220),
          child: Text(
              "Website: $url",
             overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: size_H(16.0))),
        ),
        websiteSend(oururl: "$url")
      ],
    ),
  );
}

Widget websiteSend({required String oururl }) {
  Future<void> _launched;

  return  MaterialButton(
    minWidth: 1,
    padding: const EdgeInsets.all(0.0),
    onPressed: () async {
      // _launched = _launchInWebViewOrVC(url);
      _launchURL() async {
        final url = 'https://$oururl';
        // final url = 'https://www.google.com/';
        // final url = 'www.convtech.com';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      }
      _launchURL();
    },textColor: Colors.blueAccent,
    child: Icon(Icons.web      ,size: size_H(16.0),
      // overflow: TextOverflow.ellipsis ,style: TextStyle(fontSize: size_H(18.0)),
    ),
    // child: Text("Call" , overflow: TextOverflow.ellipsis ,style: TextStyle(fontSize: size_H(18.0)),),
  );
}


String convertDateTimeDisplayFull(String date) {
  final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss');
  final DateFormat serverFormater = DateFormat('HH:mm yyyy-MM-dd');
  final DateTime displayDate = displayFormater.parse(date);
  final String formatted = serverFormater.format(displayDate);
  return formatted;
}

String convertDateTimeDisplayFullWithoutTime(String date) {
  final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss');
  final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
  final DateTime displayDate = displayFormater.parse(date);
  final String formatted = serverFormater.format(displayDate);
  return formatted;
}

SizedBox sizedBoxSpace() => SizedBox(height: size_H(8),);


String convertDateTimeDisplayAllInvoice(String date) {
  final DateFormat displayFormater = DateFormat('yyyy-MM-dd');
  final DateFormat serverFormater = DateFormat('MM-dd');
  final DateTime displayDate = displayFormater.parse(date);
  final String formatted = serverFormater.format(displayDate);
  return formatted;
}





String convertDateTimeDisplay(String date) {
  final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss');
  final DateFormat serverFormater = DateFormat('MM-dd');
  final DateTime displayDate = displayFormater.parse(date);
  final String formatted = serverFormater.format(displayDate);
  return formatted;
}


void hide_keyboard(context){
  FocusScope.of(context).requestFocus(FocusNode());
}

TextStyle ourTextStyleArabic({Color? color, double? fontSize ,FontWeight?  fontWeight }){
  // color ??= Theme_Information.Primary_Color;
  color ??= Colors.black;
  fontSize ??= 13;
  fontWeight ??= FontWeight.normal;
    // return GoogleFonts.poppins(color:  color ,fontWeight:  fontWeight, fontSize:  size_H(fontSize));
    return GoogleFonts.almarai(color:  color ,fontWeight:  fontWeight, fontSize:  size_H(fontSize));
}
Text staticWidget() => Text("Static" , style: ourTextStyle(fontSize: 18 , color: Colors.red , fontWeight: FontWeight.bold),);

String getProductPriceTax({required String price,required String tax}){
  try{
    double priceD = double.parse(price) ;
    double taxD = double.parse(tax) ;
    double total = (priceD * (taxD/100));
    return "${total}";
  }catch(e){
    return " - " ;
  }
}

TextStyle ourTextStyleEnglish({Color? color, double? fontSize ,FontWeight?  fontWeight }){
  // color ??= Theme_Information.Primary_Color;
  color ??= Colors.black;
  fontSize ??= 13;
  fontWeight ??= FontWeight.normal;
  return GoogleFonts.cairo(color:  color ,fontWeight:  fontWeight, fontSize:  size_H(fontSize));
  // return GoogleFonts.aBeeZee(color:  color ,fontWeight:  fontWeight, fontSize:  size_H(fontSize));
}

TextStyle ourTextStyle({Color? color, double? fontSize ,FontWeight?  fontWeight ,double?  height ,TextDecoration? decoration }){
  // color ??= Theme_Information.Primary_Color; ///  decoration: TextDecoration.underline,
  color ??= Colors.black;
  fontSize ??= 13;
  fontWeight ??= FontWeight.normal;
    return GoogleFonts.cairo(color:  color ,fontWeight:  fontWeight,height: height  , fontSize:  size_H(fontSize) , decoration: decoration?? TextDecoration.none );
  //
}

double size_H(var hight){
  if(hight.runtimeType.toString() == "Int"){
    hight = hight.toDouble();
  }
  return  SizeConfig.heightMultiplier! * (hight / 7.81 ) ;
}

String capitalize(name) {
  return "${name[0].toUpperCase()}${name.substring(1)}";
}
double size_W(var width){
  if(width.runtimeType.toString() == "Int"){
    width = width.toDouble();
  }
  return  SizeConfig.widthMultiplier! * (width / 3.92 ) ;}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({ WidgetBuilder? builder, RouteSettings? settings })
      : super(builder: builder!, settings: settings);

  @override
  Widget buildTransitions(BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    // transitionDuration: Duration(milliseconds: 2000),
    return new FadeTransition(opacity: animation, child: child );
    // return new ScaleTransition(scale: animation, child: child );
    // return new RotationTransition(turns: animation, child: child );
  }
}

class CircularLoadingPage extends StatelessWidget {
  const CircularLoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}


