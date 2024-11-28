import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../configuration/theme.dart';
import '../../models/IdeaModel.dart';
import '../../provider/dataProvider.dart';

class AllIdeaAdmin extends StatefulWidget {
  const AllIdeaAdmin({super.key});

  @override
  State<AllIdeaAdmin> createState() => _AllIdeaAdminState();
}

class _AllIdeaAdminState extends State<AllIdeaAdmin> {
  List<Idea> allIdeas = []  ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(microseconds: 3), () async {
      await Provider.of<DataProvider>(context, listen: false).getAllIdeas(allIdeas);
      setState(() {});
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(allIdeas!.length, (index) {
            final item =  allIdeas![index];
            return Card(
                child: ListTile(
                  onTap: (){
                    //   ideaDetails
                    Navigator.pushNamed(
                      context,
                      '/IdeaDetailsAdminPage',
                      arguments: item,
                    );
                  },
                  leading: Image.network("${item.image}" , width: size_W(25)
                    , height: size_W(25), errorBuilder: (BuildContext? context, Object? exception, StackTrace? stackTrace) {
                      return Image.asset("assets/images/logo.png" ,width: size_W(25)
                          , height: size_W(25));
                    } ,),
                  title: Text("${item.title}" , style: ourTextStyle(fontSize: 15 , fontWeight: FontWeight.w600),),
                  subtitle: Text("${item.description}" , style: ourTextStyle(),maxLines: 2,overflow: TextOverflow.ellipsis,),
                  trailing: Text(item.status?.toUpperCase()??"" , style: ourTextStyle(),),

                ));
          }),
        ),
      ),
    );
  }
}
