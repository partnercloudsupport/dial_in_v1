import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/profile.dart';
import '../profile_pages/profile_page.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/inherited_widgets.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/data/functions.dart';

class ProfileList extends StatefulWidget{

 final String _listDatabaseId;
 final Function(Profile) _giveProfile;
 final bool _isOnOverviewScreen;

 ProfileList(this._listDatabaseId, this._giveProfile, this._isOnOverviewScreen,);

 _ProfileListState createState() => new _ProfileListState();
}


class _ProfileListState extends State<ProfileList>{

  Function(Profile) _giveProfile;
  String _listDatabaseId;
  bool _isOnOverviewScreen;
  Widget _feed;
  List<Widget> _profileCards;

    @override
    initState(){
    _giveProfile = widget._giveProfile; 
    _listDatabaseId = widget._listDatabaseId;
    _isOnOverviewScreen = widget._isOnOverviewScreen;
    super.initState();
   }

   void _dealWithProfileSelection(Profile profile){

     if (_isOnOverviewScreen){

       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
        ProfilePage(isOldProfile: true, isCopying: false, isEditing: true, isNew: false, type: profile.type, referance: profile.objectId, profile: profile)));

     }else{

       _giveProfile(profile);
       Navigator.pop(context);
     }
   }

@override
    Widget build(BuildContext context) {  

      return ScopedModelDescendant<ProfilesModel>
      (builder: (context, _ ,model) =>

        StreamBuilder<List<Profile>>(
          stream:  model.profiles,
          builder: (context, snapshot) {

                if (!snapshot.hasData) { return const Center(child: Text('Loading'));
                } else if (snapshot.hasError) { return const Center(child: Text('Error'));  
                } else if (snapshot.data.length < 1) {return const Center(child: Text('No data'));
                } else {

                  return new 
                    ListView.builder(
                        itemExtent: 100,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) =>
                            ProfileCard(snapshot.data[index], (profile){})
                    );
                }
          }
        )
      );
    }
}
          

  