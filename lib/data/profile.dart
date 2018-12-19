import 'package:flutter/material.dart';
import 'package:dial_in_v1/data/item.dart';
import '../database_functions.dart';
import 'dart:io';
import 'package:dial_in_v1/data/functions.dart';
import 'package:dial_in_v1/data/images.dart';


class Profile {
  @required
  String userId;
  @required
  DateTime updatedAt;
  @required
  String objectId;
  @required
  String databaseId;
  @required
  List<Item> properties;
  @required
  String image;
  @required
  ProfileType type;
  @required
  String viewContollerId;
  @required
  int referanceNumber;
  @required
  int orderNumber = 0;
  @required
  bool isPublic = true;
  List<Profile> profiles;

  // Is it water , coffee, grinder , machine etc?

  Profile({
      this.userId,
      this.updatedAt,
      this.objectId,
      this.type,
      this.properties,
      this.image,
      this.databaseId,
      this.viewContollerId,
      this.orderNumber,
      this.profiles,
      this.isPublic
      }) {
    switch (type) {
      case ProfileType.recipe:
        this.referanceNumber = 0;
        break;

      case ProfileType.coffee:
        this.referanceNumber = 1;
        break;

      case ProfileType.grinder:
        this.referanceNumber = 2;
        break;

      case ProfileType.equipment:
        this.referanceNumber = 3;
        break;

      case ProfileType.water:
        this.referanceNumber = 4;
        break;

      case ProfileType.barista:
        this.referanceNumber = 5;
        break;

      default:
        break;
    }
    // setDefaultPic();
  }

  //  Future<void> setDefaultPic()async{if (this.image == null){ this.image = await Functions.getFile(Images.recipeSmaller);}}

  void setProfileItemValue(String itemDatabaseId, dynamic value) {
    if (value != null){
      for (var i = 0; i < this.properties.length; i++) {
        if (this.properties[i].databaseId == itemDatabaseId) {
          this.properties[i].value = value;
        }
      }
    }  
  }

  dynamic getProfileItemValue(String itemDatabaseId) {
    
    dynamic value;
    for (var i = 0; i < this.properties.length; i++) {
      if (this.properties[i].databaseId == itemDatabaseId) {
        value = this.properties[i].value;
      }
    }

    
    if (value == null) {
      if(itemDatabaseId == DatabaseIds.date || itemDatabaseId == DatabaseIds.roastDate)
      { return DateTime.now();}
      else{return '';}
    } else {
      return value;
    }
  }

  Item getProfileItem(String itemDatabaseId){
    
    Item item;
    for (var i = 0; i < this.properties.length; i++) {
      if (this.properties[i].databaseId == itemDatabaseId) {
        item = this.properties[i];
      }
    }

    if (item == null) {
      return Item();
    } else {
      return item;
    }
  } 


  void setProfileProfileTitleValue({String profileDatabaseId, String profileDatabaseIdref}) {
    for (var i = 0; i < this.profiles.length; i++) {
      if (this.profiles[i].databaseId == profileDatabaseId) {
        switch (profileDatabaseId) {
          case DatabaseIds.recipe:
            setProfileItemValue(
                 DatabaseIds.recipeId,
                 profileDatabaseIdref);
            break;

          case DatabaseIds.coffee:
            setProfileItemValue(
                 DatabaseIds.coffeeId,
                 profileDatabaseIdref);
            break;

          case DatabaseIds.water:
            setProfileItemValue(
                 DatabaseIds.waterID,
                 profileDatabaseIdref);
            break;

          case DatabaseIds.brewingEquipment:
            setProfileItemValue(
                 DatabaseIds.equipmentId,
                 profileDatabaseIdref);
            break;

          case DatabaseIds.grinder:
            setProfileItemValue(
                 DatabaseIds.grinderId,
                 profileDatabaseIdref);
            break;

          case DatabaseIds.barista:
            setProfileItemValue(
                 DatabaseIds.name,  profileDatabaseIdref);
            break;

          default:
            break;
        }
      }
    }
  }

  Future<String> getUserImage ()async{

  File image = await Functions.getFile(Images.user);
  
  String imageUrl = await DatabaseFunctions.getValueFromFireStoreWithDocRef(DatabaseIds.User, this.userId, DatabaseIds.image);
  image = await DatabaseFunctions.downloadFile(imageUrl);

  return imageUrl;
} 

 dynamic getProfileProfileItemValue(ProfileType profiletype, String itemDatabaseId) {
  dynamic value = 'Error';
   if (this.profiles != null) {
      for (var i = 0; i < this.profiles.length; i++) {
        if (this.profiles[i].type == profiletype) {
          for (var x = 0; x < this.profiles[i].properties.length; x++) {
            if (this.profiles[i].properties[x].databaseId == itemDatabaseId){
              value = this.profiles[i].properties[x].value;
            }
          }
        }
      }
   }
   return value;
 }

 Item getProfileProfileItem(ProfileType profiletype, String itemDatabaseId) {
  Item value;
   if (this.profiles != null) {
      for (var i = 0; i < this.profiles.length; i++) {
        if (this.profiles[i].type == profiletype) {
          for (var x = 0; x < this.profiles[i].properties.length; x++) {
            if (this.profiles[i].properties[x].databaseId == itemDatabaseId){
              value = this.profiles[i].properties[x];
            }
          }
        }
      }
   }
   return value;
 }

 dynamic getProfileProfileImage(ProfileType profiletype) {
  dynamic value;
   if (this.profiles != null) {
      for (var i = 0; i < this.profiles.length; i++) {
        if (this.profiles[i].type == profiletype) {
              value = this.profiles[i].image;
        }
      }
   }
   return value;
 }

 Profile getProfileProfile(ProfileType profiletype) {
  Profile value;
   if (this.profiles != null) {
      for (var i = 0; i < this.profiles.length; i++) {
        if (this.profiles[i].type == profiletype) {
              value = this.profiles[i];
        }
      }
   }
   return value;
 }

 Future<String> getProfileUserName()async{
   
  String userId = await DatabaseFunctions.getValueFromFireStoreWithDocRef(DatabaseIds.User, this.userId, DatabaseIds.userName);

  return userId;
 }

  dynamic getProfileTotalScoreValue(){
  dynamic value = 0;
   if (this.type == ProfileType.recipe) {
      for (var i = 0; i < this.profiles.length; i++) {
        if (this.profiles[i].type == ProfileType.recipe) {
          for (var x = 0; x < this.profiles[i].properties.length; x++) {
            if (
              this.profiles[i].properties[x].databaseId == DatabaseIds.balance ||
              this.profiles[i].properties[x].databaseId == DatabaseIds.strength ||
              this.profiles[i].properties[x].databaseId == DatabaseIds.flavour ||
              this.profiles[i].properties[x].databaseId == DatabaseIds.afterTaste ||
              this.profiles[i].properties[x].databaseId == DatabaseIds.acidic ||
              this.profiles[i].properties[x].databaseId == DatabaseIds.body 
              )
              
              {
              value = value + this.profiles[i].properties[x].value;
              }
        }
      }
     }
   }
    return value;
 }

  String getProfileProfileTitleValue({String profileDatabaseId}) {
    String value = 'Error';

    if (this.profiles != null) {
      for (var i = 0; i < this.profiles.length; i++) {
        if (this.profiles[i].databaseId == profileDatabaseId) {
          switch (profileDatabaseId) {
            case DatabaseIds.recipe:
              value = this.profiles[i].getProfileItemValue( DatabaseIds.recipeId);
              break;

            case DatabaseIds.coffee:
              value = this.profiles[i].getProfileItemValue( DatabaseIds.coffeeId);
              break;

            case DatabaseIds.water:
              value = this.profiles[i].getProfileItemValue( DatabaseIds.waterID);
              break;

            case DatabaseIds.brewingEquipment:
              value = this.profiles[i].getProfileItemValue( DatabaseIds.equipmentId);
              break;

            case DatabaseIds.grinder:
              value = this.profiles[i].getProfileItemValue( DatabaseIds.grinderId);
              break;

            case DatabaseIds.Barista:
              value = this.profiles[i].getProfileItemValue( DatabaseIds.name);
              break;

            case DatabaseIds.score:
              value = (this.profiles[i].getProfileItemValue( DatabaseIds.strength) +
                      this.profiles[i].getProfileItemValue( DatabaseIds.balance) +
                      this.profiles[i].getProfileItemValue( DatabaseIds.flavour) +
                      this.profiles[i].getProfileItemValue( DatabaseIds.body) +
                      this.profiles[i].getProfileItemValue( DatabaseIds.afterTaste)).toString();
              break;  

            default:
              value = 'Error';
              break;
          }
        }
      }
    }
    return value;
  }
  
 String getProfileTitleValue() {
  String value = 'Error';
   switch (this.databaseId) {
            case DatabaseIds.recipe:
              value = this.getProfileItemValue( DatabaseIds.recipeId);
              break;

            case DatabaseIds.coffee:
              value = this.getProfileItemValue( DatabaseIds.coffeeId);
              break;

            case DatabaseIds.water:
              value = this.getProfileItemValue( DatabaseIds.waterID);
              break;

            case DatabaseIds.brewingEquipment:
              value = this.getProfileItemValue( DatabaseIds.equipmentId);
              break;

            case DatabaseIds.grinder:
              value = this.getProfileItemValue( DatabaseIds.grinderId);
              break;

            case DatabaseIds.Barista:
              value = this.getProfileItemValue( DatabaseIds.name);
              break;

            case DatabaseIds.score:
            value = (this.getProfileItemValue( DatabaseIds.strength) +
                      this.getProfileItemValue( DatabaseIds.balance) +
                      this.getProfileItemValue( DatabaseIds.flavour) +
                      this.getProfileItemValue( DatabaseIds.body) +
                      this.getProfileItemValue( DatabaseIds.afterTaste)).toString();
              break;  
   }
   return value;
 }

  String getProfileProfileRefernace({String profileDatabaseId}) {
    String value = '';

    if (this.profiles != null) {
      for (var i = 0; i < this.profiles.length; i++) {
        if (this.profiles[i].databaseId == profileDatabaseId) {
              value = this.profiles[i].objectId;
        }
      }
    }
    return value;
  }

  void setSubProfile(Profile profile) {
    if (this.profiles != null){
      for (var i = 0; i < this.profiles.length; i++) {
        if (this.profiles[i].type == profile.type) {
          this.profiles[i] = profile;
        }
      }
    }
  }

/// Profile Spercific Functions

  int getTotalScore(){

    List<int> scores = [
      this.getProfileItemValue(DatabaseIds.strength),
      this.getProfileItemValue(DatabaseIds.balance),
      this.getProfileItemValue(DatabaseIds.flavour),
      this.getProfileItemValue(DatabaseIds.body),
      this.getProfileItemValue(DatabaseIds.afterTaste),
    ];
    return scores.reduce((value, element) => value + element);
  }
  


  

  int getDaysRested(){
    DateTime coffeeRoastDate = getProfileProfileItemValue(ProfileType.coffee, DatabaseIds.roastDate);
    DateTime recipeMadeTime = getProfileItemValue(DatabaseIds.date);
    int result = recipeMadeTime.difference(coffeeRoastDate).inDays;
    print(coffeeRoastDate);
    print(recipeMadeTime);
    return result;
  }
}

enum ProfileType {
  recipe,
  coffee,
  water,
  grinder,
  equipment,
  barista,
  feed,
  none
}
