import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../configuration/theme.dart';
import '../../models/IdeaModel.dart';

class IdeaDetailsPage extends StatefulWidget {
  const IdeaDetailsPage({super.key , required this.item});
  final Idea item ;
  @override
  State<IdeaDetailsPage> createState() => _IdeaDetailsPageState();
}

class _IdeaDetailsPageState extends State<IdeaDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData( color: Theme_Information.Color_1),
        backgroundColor: Theme_Information.Primary_Color.withOpacity(0.8),
        title: Text("Idea Details" , style: ourTextStyle(fontWeight: FontWeight.w600 , fontSize: 16 , color: Theme_Information.Color_1),),
        actions: [ Image.asset("assets/images/logo.png" , width:size_W(30),color: Theme_Information.Color_1,),],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network("${widget.item.image}"),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${widget.item.title}" , style: ourTextStyle(fontSize: 16 , fontWeight: FontWeight.w600),),

                             Text("${widget.item.description}" , style: ourTextStyle(),),
                          ],
                        ),
                      ),
                      Text(widget.item.status?.toUpperCase()??"" , style: ourTextStyle(fontWeight: FontWeight.bold),),

                    ],
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
      
    );
  }
}
