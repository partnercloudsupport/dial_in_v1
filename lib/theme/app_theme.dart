  import 'package:flutter/material.dart';
  import 'appColors.dart';
  import 'fonts.dart';
  
//   Theme(
//   // Find and Extend the parent theme using "copyWith". Please see the next 
//   // section for more info on `Theme.of`.
//   data: Theme.of(context).copyWith(accentColor: Colors.yellow),
//   child: FloatingActionButton(
//     onPressed: null,
//     child: Icon(Icons.add),
//   ),
// );

ThemeData buildThemeData(){

  final baseTheme = ThemeData(
     
    ///Colors
    // primarySwatch: AppColors.getColor(ColorType.toolBar),
    // primaryColorDark: AppColors.getColor(ColorType.toolBar),
    // primaryColorLight: AppColors.getColor(ColorType.toolBar),
    primaryColor: AppColors.getColor(ColorType.primarySwatch),
    // backgroundColor: AppColors.getColor(ColorType.background),
    // buttonColor: AppColors.getColor(ColorType.button),
    bottomAppBarColor: AppColors.getColor(ColorType.white),
    accentColor: AppColors.getColor(ColorType.tint),
    cardColor: Colors.white,
    // canvasColor: Colors.black12,
    cursorColor: Colors.black,
    

    /// Font
    fontFamily: Fonts.getFontType(FontType.comfortaa),

    ///Text
    textTheme: TextTheme( 
      body1: TextStyle( fontSize: 13.0), 
      body2: TextStyle( fontSize: 13.0),
      button: TextStyle( fontSize: 15.0),
      title: TextStyle( fontSize: 30.0),
    ),

     primaryTextTheme: TextTheme( 
      body1: TextStyle( fontSize: 13.0), 
      body2: TextStyle( fontSize: 13.0),
      button: TextStyle( fontSize: 15.0),
      title: TextStyle( fontSize: 30.0),
     ),
    ///Widgets
        
        // accentIconTheme: IconThemeData( ),
        // primaryIconTheme: IconThemeData(),
        // buttonTheme: ButtonThemeData(),
        tabBarTheme: TabBarTheme( 
          labelColor:Colors.white,
          unselectedLabelColor:  AppColors.getColor(ColorType.textLight),
          )

          
  );
   return baseTheme;
}


  // ThemeData buildThemeData(){

  // final baseTheme = ThemeData.dark();

  // return baseTheme.copyWith(
  //   primaryColor: AppColors.getColor(ColorType.background),
    

  // );