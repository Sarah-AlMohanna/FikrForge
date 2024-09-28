import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user_profile_model.dart';
import '../../provider/user_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  UserProfile? userProfile ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userProfile =Provider.of<UserProvider>(context , listen: false).userProfile ;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if(userProfile != null)
          Text("Welcome ${userProfile!.fillName}")
        ],
      ),
    );
  }
}
