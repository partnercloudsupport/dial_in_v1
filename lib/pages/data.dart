import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/strings.dart';
import '../widgets/custom_widgets.dart';
import 'sign_up.dart';
import '../theme/appColors.dart';
import 'profile_list.dart';


class DataPage extends StatefulWidget{
 @override
  DataPageState createState() => new DataPageState();
}

class DataPageState extends State<DataPage> with SingleTickerProviderStateMixin{

TabController controller;
TabViewDataArray _lists;

@override
void initState() { 
  super.initState();
  _lists = TabViewDataArray([

    TabViewData(ProfileList(), Tab(icon: Icon(Icons.public))),
   
    TabViewData(ProfileList(),Tab(icon: Icon(Icons.list)),),

    TabViewData(ProfileList(),Tab(icon: Icon(Icons.portrait)),),

    TabViewData(ProfileList(),Tab(icon: Icon(Icons.portrait)),),

    TabViewData(ProfileList(),Tab(icon: Icon(Icons.portrait)),),
    ]);
  controller = new TabController( vsync: this, length: _lists.ref.length);
}

@override
void dispose(){
controller.dispose();
super.dispose();
}

//
/// UI Build
///
  @override
  Widget build(BuildContext context) {
    return new 
    
    
    Scaffold(body: Column( children: <Widget>[

      Container(child:
      Material(color: AppColors.getColor(ColorType.toolBar) ,child: 
      TabBar(
        indicatorPadding: EdgeInsets.all(0.0),
        labelPadding: EdgeInsets.all(0.0),
        controller: controller,
        tabs: <Widget>[    
          _lists.ref[0].tab,
          _lists.ref[1].tab,
          _lists.ref[2].tab,
          _lists.ref[3].tab,
          _lists.ref[4].tab,

        ]),
      ),),

      Expanded(child:
        TabBarView(
          controller: controller,
          children: <Widget>[
            _lists.ref[0].screen,
            _lists.ref[1].screen,
            _lists.ref[2].screen,
            _lists.ref[3].screen,
            _lists.ref[4].screen,
          ],
        ),
      ),
    ],
    ),  

    floatingActionButton: AddButton(),   
    );   
    }
}

