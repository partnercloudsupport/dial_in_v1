import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/inherited_widgets.dart';
import 'package:dial_in_v1/data/strings.dart';

class UserProfilePage extends StatefulWidget{
 @override
  UserProfileState createState() => new UserProfileState();
}

class UserProfileState extends State<UserProfilePage>{

/// UI Build
  @override
  Widget build(BuildContext context) {
    return new Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center ,children:[

      Container(
              child: Center(
                  child: CircularPicture(
                      ProfilesModel.of(context).userImage, 100.0))),
      Text(ProfilesModel.of(context).userName),
      Text("Username"),

      Row(children: <Widget>[

        Column(children: <Widget>[
            Text('Followers num'),
            Text(StringLabels.followers),
        ],),

        Column(children: <Widget>[


        ],),

        Column(children: <Widget>[


        ],),
      ],
      )

      ]
    );
    
    
    // Container( child: Center( child:
    
    //  Card(child:Icon(Icons.access_time),),)   

    // );
    }
}