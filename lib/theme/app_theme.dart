  import 'package:flutter/material.dart';
  import 'package:dial_in_v1/theme/appColors.dart';
  import 'package:dial_in_v1/theme/fonts.dart';


ThemeData buildThemeData(){

  final baseTheme = ThemeData(
     
    ///Colors
    // primarySwatch: AppColors.getColor(ColorType.toolBar),
    primaryColorDark: Color.fromARGB(255, 240, 240, 250),
    scaffoldBackgroundColor: Color.fromARGB(255, 200, 200, 200),
    primaryColorLight: Color.fromARGB(255, 180, 184, 171),
    primaryColor: AppColors.getColor(ColorType.primarySwatch),
    buttonColor: AppColors.getColor(ColorType.primarySwatch),
    textSelectionColor: AppColors.getColor(ColorType.primarySwatch),
    backgroundColor: Color.fromARGB(255, 240, 240, 250),
    // buttonColor: AppColors.getColor(ColorType.button),
    bottomAppBarColor: AppColors.getColor(ColorType.white),
    accentColor: AppColors.getColor(ColorType.tint),
    cardColor: Color.fromARGB(255, 230, 230, 230),
    canvasColor: Color.fromARGB(255, 150, 150, 150),
    cursorColor: Colors.black,
    
    /// Font
    fontFamily: Fonts.getFontType(FontType.comfortaa),

    ///Text
    textTheme: TextTheme( 
      
      body1: TextStyle( fontSize: 11.0), 
      body2: TextStyle( fontSize: 13.0),
      button: TextStyle( fontSize: 15.0),
      title: TextStyle( fontSize: 30.0),
      display1: TextStyle( fontSize: 15, color: AppColors.getColor(ColorType.primarySwatch)),
      display2: TextStyle( fontSize: 15.0),
      display3: TextStyle( fontSize: 25.0 , color: AppColors.getColor(ColorType.primarySwatch)),
      display4: TextStyle( fontSize: 25.0),
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