import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/theme/appColors.dart';
import 'package:dial_in_v1/pages/overview_page/data.dart';
import 'package:dial_in_v1/pages/overview_page/feed.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/inherited_widgets.dart';
import 'package:dial_in_v1/pages/overview_page/current_user_page.dart';
import 'package:dial_in_v1/theme/theme_test_page.dart';
import 'package:dial_in_v1/data/functions.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/pages/custom_scaffold.dart';
import 'package:dial_in_v1/data/mini_classes.dart';


class OverviewPage extends StatefulWidget{
 @override
  OverviewPageState createState() => new OverviewPageState();
}

class OverviewPageState extends State<OverviewPage> with SingleTickerProviderStateMixin{

  TabController controller;
  TabViewDataArray _tabViews;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  
  @override
  void initState() { 
    ProfilesModel.of(context).init();
    _tabViews = TabViewDataArray(context);
    controller = new TabController(vsync: this, length: _tabViews.tabs.length);
    super.initState();
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  void logOut(BuildContext context){
    showLogOutWarning(context)
    .then((loggedOut){
       if (loggedOut != null){
        if (loggedOut is bool){  
          if (loggedOut){
            Navigator.pop(context);
          }
        }
      }
    });
  }

  Future<bool> showLogOutWarning
        (BuildContext context) async {

  return showDialog<bool>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        
        title: Text(StringLabels.logOut),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Are you sure you want to log out?'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Yes'),
            onPressed: (){ 
              Navigator.pop(context, true);             
              ProfilesModel.of(context).logOut();
              }
          ),

          FlatButton(
            child: Text('No'),
            onPressed: (){ 
              Navigator.pop(context);}               
          )
        ],
      );
    },
  );
}

  /// UI Build  
  @override
  Widget build(BuildContext context){

    return  
    ScopedModelDescendant<ProfilesModel>
     (builder: (context, _ ,model) =>
    
    Scaffold(
       
      key: _scaffoldKey,

      /// App bar 
      appBar: AppBar(
                title: Text(StringLabels.overview, style: TextStyle( fontWeight: FontWeight.w700),),
                automaticallyImplyLeading: false,
                leading: RawMaterialButton( onPressed: () {logOut(context);}, 
                  child: Icon(Icons.exit_to_app),),
                actions: <Widget>[ 
                  RawMaterialButton( onPressed: () => _scaffoldKey.currentState.openDrawer(),
                  child: Icon(Icons.menu))  ], ),
    
        drawer:  Drawer(
                // Add a ListView to the drawer. This ensures the user can scroll
                // through the options in the Drawer if there isn't enough vertical
                // space to fit everything.
                child: ListView(
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      child: Container(alignment:Alignment(0, 0),child:Text('Options', style:Theme.of(context).textTheme.title)),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    ListTile(
                      title: Text('Theme'),
                      onTap: () {
                        Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => ThemeTestPage()))
                        .then((_)=>Navigator.pop(context));
                        // Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text('Edit user profile'),
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: true, // user must tap button!
                          builder: (BuildContext context) {

                            return CustomScaffold(

                              UserInputDetails(UserDetails(userName: model.userName, email: model.userEmail, photo: model.userImage)),
                              title: 'User Details');
                           
                          },
                        ).then((_) { 
                          model.refreshUser();
                          Navigator.pop(context);});
                      },
                    ),
                  ],
                ),
              ),// We'll populate the Drawer in the next step!

      body: TabBarView(
        controller: controller,
        children: <Widget>[
          _tabViews.tabs[0].screen,
          _tabViews.tabs[1].screen,
          _tabViews.tabs[2].screen, 
                 ],
      ),
    
     bottomNavigationBar: Material(child: 
     Material( color: AppColors.getColor(ColorType.toolBar), child:
     TabBar(
        labelPadding: EdgeInsets.all(0.0),
        indicatorPadding: EdgeInsets.all(0.0),
        controller: controller,
        tabs: <Widget>[    
          _tabViews.tabs[0].tab,
          _tabViews.tabs[1].tab,
          _tabViews.tabs[2].tab,
        ],),),
      )
      )
     );
    }
}

class TabViewDataArray{

  List<TabViewData> tabs;

  TabViewDataArray(BuildContext context){ 
   
    this.tabs = [

    TabViewData(
    new FeedPage(), 
    Tab(icon: Icon(Icons.public), text: "Feed"),
    ProfileType.feed),
   
    TabViewData(new 
    DataPage(),
    Tab(icon: Icon(Icons.list),text: "Data"),
    ProfileType.feed),

    TabViewData(
      new CurrentUserPage(ProfilesModel.of(context).userProfile),
      Tab(icon: Icon(Icons.portrait),text: "User"),
      ProfileType.none),
    ];
  }
}


class UserInputDetails extends StatefulWidget {
  
  UserDetails _userDetails = UserDetails();

  UserInputDetails(this._userDetails,);

  _UserInputDetailsState createState() => _UserInputDetailsState();
}

class _UserInputDetailsState extends State<UserInputDetails> {
  //TODO;
  final _formKey = GlobalKey<FormState>();

  UserDetails _userDetails = UserDetails();


  void initState() { 
    super.initState();

  }

  
  @override
  Widget build(BuildContext context) {
    return 
    
    Container( margin:EdgeInsets.all(10), child: 
    Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[

          Container( padding: EdgeInsets.all(20.0), alignment: Alignment(0, 0),
              child: 
              InkWell(
               onTap:(){ 
                    Functions.getimageFromCameraOrGallery(
                      context,(String image){ setState(() {_userDetails.photo = image;});});
                   },
                child: Container(width: 200.0, height: 200.0, 
                decoration: BoxDecoration(
                  shape: BoxShape.circle, 
                  border: Border(),
                  boxShadow: [BoxShadow(color: Colors.black, offset: Offset(2.0, 2.0))],), 
                child:ClipRRect(
                  borderRadius: new BorderRadius.circular(200),
                  child: Image.network(_userDetails.photo ?? '', fit: BoxFit.cover))
                ))
          ),

          ///Username
          TextFormField(
            decoration: InputDecoration(labelText: StringLabels.userName),
            initialValue: _userDetails.userName ?? '',
            validator: (String value) {
              if (value.isEmpty) {
                return 'Enter some text';
              }
            },
            onSaved: (value){_userDetails.userName = value;}
          ),

           ///Motto
            TextFormField(
            initialValue: _userDetails.motto ?? '',
            decoration: InputDecoration(
                          labelText: StringLabels.motto,
                          hasFloatingPlaceholder: true,
                                      ),
            obscureText: false,
            // TODO
            onSaved: (String value){if (value != null || value != '');}

          ),

          /// Email
          TextFormField(
            decoration: InputDecoration(labelText: StringLabels.email),
            initialValue: _userDetails.email ?? '',
            validator: (String value) {
              if (value.isEmpty) {
                return 'Please enter a valid email';
              }
            },
            onSaved: (value){_userDetails.email = value;}
          ),

          ///Password
          TextFormField(
            decoration: InputDecoration(
                          labelText: StringLabels.password,
                          hasFloatingPlaceholder: true,
                          helperText: 'If applicable'
                                      ),
            obscureText: true,
            onSaved: (String value){if (value != null || value != '')_userDetails.password = value;}
          ),

          /// Submit button
            Container(width: 100,padding: const EdgeInsets.symmetric(vertical: 16.0), child: 
            RaisedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, we want to show a Snackbar
                  _formKey.currentState.save();
                  DatabaseFunctions.updateUserProfile(_userDetails)
                  .then((_){ Navigator.pop(context); Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('Processing Data')));})
                  .catchError((String error)=> PopUps.showAlert('Warning', error, 'ok', () => Navigator.pop(context), context));
                }
              },
              child: Text('Submit'),
            ),
            )
          
        ],
      ),
      ) 
    );
  }
}



