import 'package:flutter/material.dart';
import 'item.dart';
import '../database_functions.dart';
import 'dart:io';
import 'functions.dart';
import '../data/images.dart';


class Profile {
  @required
  DateTime updatedAt;
  @required
  String objectId;
  @required
  String databaseId;
  @required
  List<Item> properties;
  @required
  File image;
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

  Profile(
      {this.updatedAt,
      this.objectId,
      this.type,
      this.properties,
      this.image,
      this.databaseId,
      this.viewContollerId,
      this.orderNumber,
      this.profiles,
      this.isPublic}) {
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

   Future<void> setDefaultPic()async{if (this.image == null){ this.image = await Functions.getFile(Images.recipeSmaller);}}

  void setProfileItemValue(String itemDatabaseId, dynamic value) {
    for (var i = 0; i < this.properties.length; i++) {
      if (this.properties[i].databaseId == itemDatabaseId) {
        this.properties[i].value = value;
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
      return '';
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


  void setProfileProfileTitleValue(
      {String profileDatabaseId, String profileDatabaseIdref}) {
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
              return 'Error';
              break;
          }
        }
      }
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
