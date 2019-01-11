import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/pages/profile_pages/profile_page.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/inherited_widgets.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/routes.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";


/// Profile list
class ProfileList extends StatefulWidget{

 final ProfileType _profilesType;
 

 ProfileList(this._profilesType,);

 _ProfileListState createState() => new _ProfileListState();
}
class _ProfileListState extends State<ProfileList>{

  RefreshController _refreshController = new RefreshController();

   void _dealWithProfileSelection(Profile profile){

       Navigator.push(context, SlowerRoute((BuildContext context) =>
        ProfilePage(isFromUserFeed: false, isFromProfile: false ,isOldProfile: true, isCopying: false, isEditing: false, isNew: false, type: profile.type, referance: profile.objectId, profile: profile)));
  }

  void _deleteProfile(Profile profile, BuildContext context){

    PopUps.yesOrNoDioLog(context, 
      'Warning', 
      'Are you sure you want to delete this profile?', 
      (isYes) => setState((){ 
      
        if(isYes) { Navigator.pop(context);
                    ProfilesModel.of(context).delete(profile); 
                    Navigator.pop(context);
                     Scaffold
                    .of(context)
                    .showSnackBar(SnackBar(content: Text("Profile deleted"),duration: Duration(seconds: 2),));}
        else{ Navigator.pop(context);}
    })
    );   
  }

  @override
  void didUpdateWidget(dynamic oldWidget) {
    
    super.didUpdateWidget(oldWidget);
  }

  void _onRefresh(bool up, ProfilesModel model)async{
		if(up){

		   //headerIndicator callback
		   model.profiles(widget._profilesType); 
       new Future.delayed(const Duration(seconds: 2))
                               .then((val) {
                                 _refreshController.sendBack(true, RefreshStatus.completed);
                           }); 
		}
		else{
			//footerIndicator Callback
		}
  }


@override
    Widget build(BuildContext context) {  

      return ScopedModelDescendant<ProfilesModel>
      (builder: (context, _ ,model) =>

        StreamBuilder<List<Profile>>(
          stream:  model.profiles(widget._profilesType),
          builder: (BuildContext context, AsyncSnapshot<List<Profile>>snapshot) {
            if (!snapshot.hasData) { return  
              Center(child:
                Column
                (mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[CircularProgressIndicator(),
                Container(margin: EdgeInsets.all(20.0),child: Text('Loading...'),) ,],));

            } else if (snapshot.hasError) { return const Center(child: Text('Error'));  
            } else if (snapshot.data.length < 1) {
              return  Stack(children: <Widget>[ 
                         Center(child:
                           Column
                           (mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[
                             Container(child: Icon(Icons.no_sim),),
                             Container(margin: EdgeInsets.all(20.0),child: Text('No Data',style: Theme.of(context).textTheme.display3,),) ,],)),
                             ProfileRefresher(ListView(children: <Widget>[],))
                       ],);

            } else {
              Iterable<Profile> _reversedList = snapshot.data.reversed;
              List<Profile> _list = new List<Profile>();
                _reversedList.forEach((x){_list.add(x);});
                // _refreshController.sendBack(true, RefreshStatus.completed);
              return new 
               SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                onRefresh: (up) => _onRefresh(up, model),
                child: 
                ListView.builder(
                    itemExtent: 120,
                    itemCount: _list.length,
                    itemBuilder: (BuildContext context, int index) =>
                    ProfileCard(_list[index], _dealWithProfileSelection, _deleteProfile)
                )
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

 ProfileListDialog(this._profilesType, this._giveProfile, );

 _ProfileListDialogState createState() => new _ProfileListDialogState();
}
class _ProfileListDialogState extends State<ProfileListDialog>{

   void _dealWithProfileSelection(Profile profile){

       widget._giveProfile(profile);
       Navigator.pop(context);
  }

  void _deleteProfile(Profile profile, BuildContext context){

    PopUps.yesOrNoDioLog(context, 
      'Warning', 
      'Are you sure you want to delete this profile?', 
      (isYes) => setState((){ 
      
        if(isYes) {
          Navigator.pop(context);
          ProfilesModel.of(context).delete(profile); 
                          Navigator.pop(context);}
        else{Navigator.pop(context);}
    
      })
    ); 
  }
  

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
                    itemExtent: 100,
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
                         

  