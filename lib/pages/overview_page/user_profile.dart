import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/strings.dart';
import '../../widgets/custom_widgets.dart';


class UserProfilePage extends StatefulWidget{
 @override
  UserProfileState createState() => new UserProfileState();
}

class UserProfileState extends State<UserProfilePage>{

//
/// UI Build
///
  @override
  Widget build(BuildContext context) {
    return new Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center ,children:[

      Container(
              child: Center(
                  child: CircularPicture(
                      Image.asset('assets/images/user.png'), 100.0))),


      Text("Name"),
      Text("Username")



    ]

    );
    
    
    Container( child: Center( child:
    
     Card(child:Icon(Icons.access_time),),)   

    );}
}