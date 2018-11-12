// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'data/strings.dart';

class DatabaseFunctions {
  static String coreDataId = 'coreDataId';
  static String updatedAt = 'updatedAt';
  static String userName = 'username';
  static String email = 'email';
  static String currentUser = 'currentUser';
  static String password = 'password';
  static String username = 'username';
  static String objectId = 'objectId';
  static String brewWeight = 'brewWeight';
  static String Barista = 'Barista';
  static String name = 'name';
  static String data = 'data';
  static String User = 'User';
  static String altitude = 'altitude';
  static String method = 'method';
  static String density = 'density';
  static String moisture = 'moistureContent';
  static String aW = 'waterActivity';
  static String notes = 'notes';
  static String level = 'level';
  static String barista = 'barista';
  static String date = 'date';
  static String totalScore = 'totalScore';
  static String recipeId = 'recipeId';
  static String tasteBalance = 'tasteBalance';
  static String tactile = 'tactile';
  static String sweet = 'sweet';
  static String acidic = 'acidic';
  static String flavour = 'flavour';
  static String bitter = 'bitter';
  static String weight = 'weight';
  static String texture = 'texture';
  static String finish = 'finish';
  static String grindSetting = 'grindSetting';
  static String descriptors = 'descriptors';
  static String body = 'body';
  static String balance = 'balance';
  static String afterTaste = 'afterTaste';
  static String water = 'Water';
  static String brewingEquipment = 'BrewingEquipment';
  static String coffee = 'Coffee';
  static String grinder = 'Grinder';
  static String creationDate = 'createdAt';
  static String recipe = 'Recipe';
  static String brewingDose = 'dose';
  static String yield = 'yield';
  static String time = 'time';
  static String temparature = 'temparature';
  static String tds = 'tds';
  static String score = 'score';
  static String preinfusion = 'preInfusion';
  static String coffeeId = 'coffeeID';
  static String producer = 'producer';
  static String lot = 'lot';
  static String farm = 'farm';
  static String region = 'region';
  static String country = 'country';
  static String beanType = 'beanType';
  static String beanSize = 'beanSize';
  static String roastProfile = 'roastProfile';
  static String roastDate = 'roastDate';
  static String processingMethod = 'processingMethod';
  static String roasteryName = 'roasteryName';
  static String grinderId = 'grinderId';
  static String grinderMake = 'grinderMake';
  static String grinderModel = 'grinderModel';
  static String equipmentMake = 'equipmentMake';
  static String equipmentModel = 'equipmentModel';
  static String burrs = 'burrs';
  static String testTemparature = 'testTemparature';
  static String gh = 'gh';
  static String kh = 'kh';
  static String ppm = 'ppm';
  static String ph = 'ph';
  static String equipmentId = 'equipmentId';
  static String equipmentType = 'equipmentType';
  static String waterID = 'waterId';
  static String user = 'user';
  static String userImage = 'userPicture';
  static String brewingEquipmentImage = 'brewingEquipmentImage';
  static String coffeeImage = 'coffeeImage';
  static String grinderImage = 'grinderImage';
  static String recipeImage = 'recipeImage';
  static String waterImage = 'waterImage';
  static String picture = 'picture';

  static Future<void> logIn(String emailUser, String password,
      Function(bool, String) completion) async {
          // try {
          //   FirebaseUser user = await FirebaseAuth.instance
          //       .signInWithEmailAndPassword(email: emailUser, password: password);
          //   completion(true, StringLabels.loggedIn);
          // } catch (e) {
          //   completion(false, e);
          // }
  }

  static Future<void> signUp(String emailUser, String password,
      Function(bool, String) completion) async {
    // try {
    //   FirebaseUser user = await FirebaseAuth.instance
    //       .createUserWithEmailAndPassword(email: emailUser, password: password);
    //   completion(true, StringLabels.signedYouUp);
    // } catch (e) {
    //   print(e.message);
    // }
  }

  static Future <void> logOut(Function signOutView)  async{
    signOutView();
    // await FirebaseAuth.instance.signOut();
    print('Logged out');
}
}
