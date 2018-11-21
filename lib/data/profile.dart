import 'package:flutter/material.dart';
import 'item.dart';
import '../database_functions.dart';

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
  Image image;
  @required
  ProfileType type;
  @required
  String viewContollerId;
  @required
  int referanceNumber;
  @required
  int orderNumber = 0;
  @required
  bool public = true;
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
      this.profiles}) {
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
  }

  void setProfileItemValue({String itemDatabaseId, dynamic value}) {
    for (var i = 0; i < this.properties.length; i++) {
      if (this.properties[i].databaseId == itemDatabaseId) {
        this.properties[i].value = value;
      }
    }
  }

  dynamic getProfileItemValue({String itemDatabaseId}) {
    for (var i = 0; i < this.properties.length; i++) {
      if (this.properties[i].databaseId == itemDatabaseId) {
        return this.properties[i].value;
      }
    }
  }

  void setProfileProfileTitleValue(
      {String profileDatabaseId, String profileDatabaseIdref}) {
    for (var i = 0; i < this.profiles.length; i++) {
      if (this.profiles[i].databaseId == profileDatabaseId) {
        switch (profileDatabaseId) {
          case DatabaseIds.recipe:
            setProfileItemValue(
                itemDatabaseId: DatabaseIds.recipeId,
                value: profileDatabaseIdref);
            break;

          case DatabaseIds.coffee:
            setProfileItemValue(
                itemDatabaseId: DatabaseIds.coffeeId,
                value: profileDatabaseIdref);
            break;

          case DatabaseIds.water:
            setProfileItemValue(
                itemDatabaseId: DatabaseIds.waterID,
                value: profileDatabaseIdref);
            break;

          case DatabaseIds.brewingEquipment:
            setProfileItemValue(
                itemDatabaseId: DatabaseIds.equipmentId,
                value: profileDatabaseIdref);
            break;

          case DatabaseIds.grinder:
            setProfileItemValue(
                itemDatabaseId: DatabaseIds.grinderId,
                value: profileDatabaseIdref);
            break;

          case DatabaseIds.barista:
            setProfileItemValue(
                itemDatabaseId: DatabaseIds.name, value: profileDatabaseIdref);
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
              value = getProfileItemValue(itemDatabaseId: DatabaseIds.recipeId);
              break;

            case DatabaseIds.coffee:
              value = getProfileItemValue(itemDatabaseId: DatabaseIds.coffeeId);
              break;

            case DatabaseIds.water:
              value = getProfileItemValue(itemDatabaseId: DatabaseIds.waterID);
              break;

            case DatabaseIds.brewingEquipment:
              value = getProfileItemValue(
                  itemDatabaseId: DatabaseIds.equipmentId);
              break;

            case DatabaseIds.grinder:
              value = getProfileItemValue(itemDatabaseId: DatabaseIds.grinderId);
              break;

            case DatabaseIds.barista:
              value = getProfileItemValue(itemDatabaseId: DatabaseIds.name);
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
