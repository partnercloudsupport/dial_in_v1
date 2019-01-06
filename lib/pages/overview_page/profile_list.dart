import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/pages/profile_pages/profile_page.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/inherited_widgets.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/data/functions.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/routes.dart';

/// Profile list
class ProfileList extends StatefulWidget{

 final ProfileType _profilesType;
 final Function(Profile) _giveProfile;
 final bool _isOnOverviewScreen;

 ProfileList(this._profilesType, this._giveProfile, this._isOnOverviewScreen,);

 _ProfileListState createState() => new _ProfileListState();
}
class _ProfileListState extends State<ProfileList>{

   void _dealWithProfileSelection(Profile profile){

     if (widget._isOnOverviewScreen){

       Navigator.push(context, SlowerRoute((BuildContext context) =>
        ProfilePage(isOldProfile: true, isCopying: false, isEditing: true, isNew: false, type: profile.type, referance: profile.objectId, profile: profile)));

     }else{

       widget._giveProfile(profile);
       Navigator.pop(context);
     }
  }

  void _deleteProfile(Profile profile){
    
    setState((){ProfilesModel.of(context).delete(profile);});
  }

  @override
void didUpdateWidget(dynamic oldWidget) {
    
    super.didUpdateWidget(oldWidget);
}

@override
    Widget build(BuildContext context) {  

      return ScopedModelDescendant<ProfilesModel>
      (builder: (context, _ ,model) =>

        StreamBuilder<List<Profile>>(
          stream:  model.profiles(widget._profilesType),
          builder: (context, snapshot) {

            if (!snapshot.hasData) { return  
              Center(child:
                Column
                (mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[CircularProgressIndicator(),
                Container(margin: EdgeInsets.all(20.0),child: Text('Loading...'),) ,],));

            } else if (snapshot.hasError) { return const Center(child: Text('Error'));  
            } else if (snapshot.data.length < 1) {return const Center(child: Text('No data'));
            } else {
              Iterable<Profile> _reversedList = snapshot.data.reversed;
              List<Profile> _list = new List<Profile>();
                _reversedList.forEach((x){_list.add(x);});
              return new 
                ListView.builder(
                    itemExtent: 120,
                    itemCount: _list.length,
                    itemBuilder: (BuildContext context, int index) =>
                    ProfileCard(_list[index], _dealWithProfileSelection, _deleteProfile)
                );
            }
          }
        )
      );
    }
}


/// List Diolog
class ProfileListDialog extends StatefulWidget{

 final ProfileType _profilesType;
 final Function(Profile) _giveProfile;
 final bool _isOnOverviewScreen;

 ProfileListDialog(this._profilesType, this._giveProfile, this._isOnOverviewScreen,);

 _ProfileListDialogState createState() => new _ProfileListDialogState();
}
class _ProfileListDialogState extends State<ProfileListDialog>{

   void _dealWithProfileSelection(Profile profile){

     if (widget._isOnOverviewScreen){

       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
        ProfilePage(isOldProfile: true, isCopying: false, isEditing: true, isNew: false, type: profile.type, referance: profile.objectId, profile: profile)));

     }else{

       widget._giveProfile(profile);
       Navigator.pop(context);
     }
  }

   void _deleteProfile(Profile profile){DatabaseFunctions.deleteProfile(profile)
   .then(setState);}
  

    @override
    Widget build(BuildContext context) {  

    return StreamBuilder<List<Profile>>(
        stream: ProfilesModel.of(context).profiles(widget._profilesType),
        builder: (BuildContext context, AsyncSnapshot<List<Profile>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return LinearProgressIndicator();
            case ConnectionState.active:
            case ConnectionState.done:
              if (!snapshot.hasData) {
                return  Center(child:
              Column
              (mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[CircularProgressIndicator(),
              Container(margin: EdgeInsets.all(20.0),child: Text('Loading...'),) ,],));

              } else if (snapshot.hasError) {
                print(snapshot.error.toString());
                return  Center(child: Text('Error: ${snapshot.error}'));

              } else if (snapshot.data.length < 1) {
                return const Center(child: Text('No data'));

              } else {
              
              Iterable<Profile> _reversedList = snapshot.data.reversed;
              List<Profile> _list = new List<Profile>();
                _reversedList.forEach((x){_list.add(x);});
              return new 
               Container(height: 600, child: 
                ListView.builder(
                    itemExtent: 120,
                    itemCount: _list.length,
                    itemBuilder: (BuildContext context, int index) =>
                    ProfileCard(_list[index], _dealWithProfileSelection, _deleteProfile)
                )
                );
              }
          }
        }
    );
  }
}
                         

  