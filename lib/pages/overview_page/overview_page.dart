import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/theme/appColors.dart';
import 'package:dial_in_v1/pages/overview_page/data.dart';
import 'package:dial_in_v1/pages/overview_page/feed.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/inherited_widgets.dart';
import 'package:dial_in_v1/pages/overview_page/user_profile.dart';



class OverviewPage extends StatefulWidget{
 @override
  OverviewPageState createState() => new OverviewPageState();
}

class OverviewPageState extends State<OverviewPage> with SingleTickerProviderStateMixin{

  TabController controller;
  TabViewDataArray _tabViews;
  

  @override
  void initState() { 
    super.initState();
    _tabViews = TabViewDataArray();
    controller = new TabController(vsync: this, length: _tabViews.tabs.length);
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
              DatabaseFunctions.logOut((){});
              Navigator.pop(context, true);}               
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
  Widget build(BuildContext context) {

    ProfilesModel.of(context).init();

    return  Scaffold(
       
      /// 
      /// App bar 
      ///
      appBar: AppBar(title: Text(StringLabels.overview, style: TextStyle( fontWeight: FontWeight.w700),), automaticallyImplyLeading: false,
      leading: RawMaterialButton( onPressed: (){logOut(context);}, 
      child: Icon(Icons.exit_to_app),), 
      actions: <Widget>[ 
        RawMaterialButton( onPressed: () => Navigator.pop(context), child: Icon(Icons.menu))  ], ),
    
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
      );
    }
}


class TabViewDataArray{

  List<TabViewData> tabs;

 TabViewDataArray(){ 
   
    this.tabs = [

    TabViewData(
    new FeedPage(), 
    Tab(icon: Icon(Icons.public), text: "Feed"),
    ProfileType.feed),
   
    TabViewData(new 
    DataPage(),
    Tab(icon: Icon(Icons.list), text: "Data"),
    ProfileType.feed),

    TabViewData(new UserProfilePage(),Tab(icon: Icon(Icons.portrait), text: "User"), ProfileType.none),
    ];
 }
}