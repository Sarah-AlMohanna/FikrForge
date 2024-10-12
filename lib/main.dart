import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:forgeapp/provider/dataProvider.dart';
import 'package:forgeapp/provider/user_provider.dart';
import 'package:forgeapp/screnns/auth/login_screen.dart';
import 'package:forgeapp/screnns/auth/register_screen.dart';
import 'package:forgeapp/screnns/auth/welcome_screen.dart';
import 'package:forgeapp/screnns/home/home_page.dart';
import 'package:forgeapp/screnns/home/home_page_entre_preneur.dart';
import 'package:forgeapp/screnns/ideas/add_Idea.dart';
import 'package:forgeapp/screnns/ideas/idea_details.dart';
import 'package:forgeapp/screnns/profile/update_entrepreneur_profile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'configuration/size_config.dart';
import 'configuration/theme.dart';
import 'models/IdeaModel.dart';
import 'models/user_profile_model.dart';

SharedPreferences? loginDataHistory;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyD6yyNIgyx4H68ZD5n9L-lPeBEEFY_XjMM",
        authDomain: "fikr-forge.firebaseapp.com",
        projectId: "fikr-forge",
        storageBucket: "fikr-forge.appspot.com",
        messagingSenderId: "459507615197",
        appId: "1:459507615197:web:aed947c7f5c6a820ea6234",
        measurementId: "G-5GQBLSP1E5"
    ),
  );
  loginDataHistory = await SharedPreferences.getInstance();

  ///
  /// /Users/u/Desktop/flutter_3.19.0/bin/flutter pub add cloud_firestore
  /// /Users/u/Desktop/flutter_3.19.0/bin/flutter config --enable-web
  /// /Users/u/Desktop/flutter_3.19.0/bin/flutter create .
  ///
  /// /Users/u/Desktop/flutter_3.19.0/bin/flutter build web
  ///                                                 firebase deploy
  ///
  ///

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.landscapeLeft,
  ]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<DataProvider>(create: (_) => DataProvider()),
      ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            EasyLoading.instance.textStyle = ourTextStyle(color: Theme_Information.Color_1);
            return MaterialApp(
              builder: EasyLoading.init(),
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              title: '',
              // home: WelcomeScreen(),
              initialRoute: '/welcome',
              routes: {
                '/welcome': (context) => WelcomeScreen(),
                '/login': (context) => LoginScreen(), // Add your new page here
                '/registration': (context) => RegistrationScreen(), // Add your new page here
                '/homePage': (context) => HomePage(), // Add your new page here
                '/homePageEntrepreneur': (context) => HomePageEntrepreneur(), // Add your new page here
                '/addIdea': (context) => AddIdeaPage(), // Add your new page here
                '/ideaDetails': (context) {
                  final Idea item = ModalRoute.of(context)!.settings.arguments as Idea;
                  return IdeaDetailsPage(item: item);
                },
                '/UpdateEntrepreneurProfile': (context) {
                  final UserProfile userProfile = ModalRoute.of(context)!.settings.arguments as UserProfile;
                  return UpdateEntrepreneurProfile(userProfile: userProfile);
                },
              },


            );
          },
        );
      },
    );
  }


}