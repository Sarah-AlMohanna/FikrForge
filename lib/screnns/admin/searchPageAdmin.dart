import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../commenwidget/textInput.dart';
import '../../configuration/theme.dart';
import '../../models/user_profile_model.dart';
import '../../provider/dataProvider.dart';

class SearchPageADMIN extends StatefulWidget {
  const SearchPageADMIN({super.key });

  @override
  State<SearchPageADMIN> createState() => _SearchPageADMINState();
}

class _SearchPageADMINState extends State<SearchPageADMIN> {
  TextEditingController userName = TextEditingController();
  String searchQuery = '';

  List<UserProfile> usersData = [] ;
  List<UserProfile> filteredUsers = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Provider.of<DataProvider>(context, listen: false).getUsersData(usersData , isIdeaUsers: true);
      filteredUsers = List.of(usersData);
      setState(() {});
    });
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredUsers = usersData.where((user) {
        return user.fillName?.toLowerCase().contains(query.toLowerCase()) ?? false;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: size_H(10),),
        TextField(
          onChanged: updateSearchQuery,
          decoration: InputDecoration(
            labelText: 'Search by Full Name',
            border: OutlineInputBorder(),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredUsers.length,
            itemBuilder: (context, index) {
              final user = filteredUsers[index];
              return ListTile(
                onTap: (){
                  Navigator.pushNamed(
                    context,
                    '/UserDetailsPageAdmin',
                    arguments: user,
                  ).then((value) async {
                    if(value != null){
                      await Provider.of<DataProvider>(context, listen: false).getUsersData(usersData , isIdeaUsers: true);
                      filteredUsers = List.of(usersData);
                      setState(() {});
                    }
                  });
                },
                title: Text(user.fillName ?? ' - '),
                subtitle: Text(user.userName ?? ''),
                leading: user.profileImage != null
                    ? Image.network(user.profileImage!, width: size_W(25),)
                    : Image.network("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png" , width: size_W(25),),
              );
            },
          ),
        ),
      ],
    );
  }
}
