import 'item.dart';
import '../database_functions.dart';
import 'strings.dart';
import 'package:flutter/material.dart';
import 'profile.dart';
import 'images.dart';



class Functions{

  static Profile setProfileItemValue({Profile profile, String keyDatabaseId, dynamic value}){

      for (var i = 0; i < profile.properties.length; i++) {

          if(profile.properties[i].databaseId == keyDatabaseId){ profile.properties[i].value = value ;}
      }

      return profile;
  }


  static String getProfileTypeString(ProfileType type){
    
    switch (type){

      case ProfileType.recipe:   
      return  StringLabels.recipe;
      break;

      case ProfileType.coffee:   
      return  StringLabels.coffee;
      break;

      case ProfileType.water:   
      return  StringLabels.water;
      break;

      case ProfileType.equipment:   
      return  StringLabels.brewingEquipment;
      break;

      case ProfileType.grinder:   
      return  StringLabels.grinder;
      break;

      case ProfileType.barista:   
      return  StringLabels.barista;
      break;

      case ProfileType.none:   
      return  StringLabels.none;
      break;

      case ProfileType.feed:   
      return  StringLabels.feed;
      break;

      default:   
      return  StringLabels.feed;
      break;
    }
  }


  static Profile createBlankProfile(ProfileType profileType){
    switch(profileType){

      case ProfileType.recipe:   
      return  new Profile(
              updatedAt: DateTime.now(),
              objectId: '',
              // image: document[DatabaseIds.image].toString(),
              databaseId: DatabaseIds.databaseId,
              orderNumber: 0,
              properties: [
                createBlankItem(DatabaseIds.barista),
                createBlankItem(DatabaseIds.date),
                createBlankItem(DatabaseIds.grindSetting),
                createBlankItem(DatabaseIds.temparature),
                createBlankItem(DatabaseIds.brewingDose),
                createBlankItem(DatabaseIds.preinfusion),
                createBlankItem(DatabaseIds.yield),
                createBlankItem(DatabaseIds.brewWeight),
                createBlankItem(DatabaseIds.time),
                createBlankItem(DatabaseIds.tds),
                createBlankItem(DatabaseIds.notes),
                createBlankItem(DatabaseIds.flavour),
                createBlankItem(DatabaseIds.body),
                createBlankItem(DatabaseIds.balance),
                createBlankItem(DatabaseIds.afterTaste),
                createBlankItem(DatabaseIds.strength),
                createBlankItem(DatabaseIds.descriptors),
              ],
              profiles: [
                createBlankProfile(ProfileType.coffee),
                createBlankProfile(ProfileType.barista),
                createBlankProfile(ProfileType.equipment),
                createBlankProfile(ProfileType.grinder),
                createBlankProfile(ProfileType.water),
                createBlankProfile(ProfileType.barista),
              ]
              );
      break;

      case ProfileType.water:   
      return  new Profile(
              updatedAt: DateTime.now(),
              objectId: '',
              // image: document[DatabaseIds.image].toString(),
              databaseId: DatabaseIds.databaseId,
              orderNumber: 0,
              properties: [
                createBlankItem(DatabaseIds.waterID),
                createBlankItem(DatabaseIds.date),
                createBlankItem(DatabaseIds.ppm),
                createBlankItem(DatabaseIds.gh),
                createBlankItem(DatabaseIds.kh),
                createBlankItem(DatabaseIds.ph),
              ]
              );
      break;

      case ProfileType.coffee:   
      return  new Profile(
              updatedAt: DateTime.now(),
              objectId: '',
              // image: document[DatabaseIds.image].toString(),
              databaseId: DatabaseIds.databaseId,
              orderNumber: 0,
              properties: [
                createBlankItem(DatabaseIds.coffeeId),
                createBlankItem(DatabaseIds.country),
                createBlankItem(DatabaseIds.region),
                createBlankItem(DatabaseIds.farm),
                createBlankItem(DatabaseIds.producer),
                createBlankItem(DatabaseIds.lot),
                createBlankItem(DatabaseIds.altitude),
                createBlankItem(DatabaseIds.roastDate),
                createBlankItem(DatabaseIds.roastProfile),
                createBlankItem(DatabaseIds.roasteryName),
                createBlankItem(DatabaseIds.beanType),
                createBlankItem(DatabaseIds.beanSize),
                createBlankItem(DatabaseIds.processingMethod),
                createBlankItem(DatabaseIds.density),
                createBlankItem(DatabaseIds.aW),
                createBlankItem(DatabaseIds.moisture),
              ]
              );
      break;

      case ProfileType.equipment:   
      return  new Profile(
              updatedAt: DateTime.now(),
              objectId: '',
              // image: document[DatabaseIds.image].toString(),
              databaseId: DatabaseIds.databaseId,
              orderNumber: 0,
              properties: [
                createBlankItem(DatabaseIds.equipmentId),
                createBlankItem(DatabaseIds.equipmentMake),
                createBlankItem(DatabaseIds.equipmentModel),
                createBlankItem(DatabaseIds.method),
                createBlankItem(DatabaseIds.type),
              ],
              );
      break;

      case ProfileType.feed:   
      return  new Profile(
              updatedAt: DateTime.now(),
              objectId: '',
              // image: document[DatabaseIds.image].toString(),
              databaseId: DatabaseIds.databaseId,
              orderNumber: 0,
              properties: [createBlankItem(DatabaseIds.type),],
              );
      break;

      case ProfileType.grinder:   
      return  new Profile(
              updatedAt: DateTime.now(),
              objectId: '',
              // image: document[DatabaseIds.image].toString(),
              databaseId: DatabaseIds.databaseId,
              orderNumber: 0,
              properties: [
                createBlankItem(DatabaseIds.grinderId),
                createBlankItem(DatabaseIds.grinderMake),
                createBlankItem(DatabaseIds.grinderModel),
                createBlankItem(DatabaseIds.method),
                createBlankItem(DatabaseIds.type),
              ],
              );
      break;

      case ProfileType.none:   
      return  new Profile(
              updatedAt: DateTime.now(),
              objectId: '',
              // image: document[DatabaseIds.image].toString(),
              databaseId: DatabaseIds.databaseId,
              orderNumber: 0,
              properties: [createBlankItem(DatabaseIds.type)],
              );
      break;

      case ProfileType.barista:   
      return  new Profile(
              updatedAt: DateTime.now(),
              objectId: '',
              // image: document[DatabaseIds.image].toString(),
              databaseId: DatabaseIds.databaseId,
              orderNumber: 0,
              properties: [createBlankItem(DatabaseIds.type)],
              );
      break;

      default:   
      return  new Profile(
              updatedAt: DateTime.now(),
              objectId: '',
              // image: document[DatabaseIds.image].toString(),
              databaseId: DatabaseIds.databaseId,
              orderNumber: 0,
              properties: [
                createBlankItem(DatabaseIds.name),
                createBlankItem(DatabaseIds.level),
                createBlankItem(DatabaseIds.notes)
              ],
              );
      break;
      
      
    }
  }


  static Profile createProfile(String databaseId, List<Item> _properties){
    
    switch(databaseId){

      case DatabaseIds.recipe:   
      return  new Profile(
              updatedAt: DateTime.now(),
              objectId: '',
              type: ProfileType.recipe,
              image: Image.asset(Images.whiteRecipe200X200),
              databaseId: databaseId,
              orderNumber: 0,
              properties: _properties,
              profiles:  [

                createProfile(databaseId, _properties)

              ]
              );
      break;

      case DatabaseIds.coffee:   
      return  new Profile(
              updatedAt: DateTime.now(),
              objectId: '',
              type: ProfileType.coffee,
              image: Image.asset(Images.coffeeBeans),
              databaseId: databaseId,
              orderNumber: 1,
              properties: _properties
              );
      break;

      case DatabaseIds.grinder:   
      return  new Profile(
              updatedAt: DateTime.now(),
              objectId: '',
              type: ProfileType.grinder,
              image: Image.asset(Images.grinder),
              databaseId: databaseId,
              orderNumber: 0,
              properties: _properties
              );
      break;

      case DatabaseIds.brewingEquipment:   
      return  new Profile(
              updatedAt: DateTime.now(),
              objectId: '',
              type: ProfileType.equipment,
              image: Image.asset(Images.groupHandle),
              databaseId: databaseId,
              orderNumber: 0,
              properties: _properties
              );
      break;

      case DatabaseIds.water:   
      return  new Profile(
              updatedAt: DateTime.now(),
              objectId: '',
              type: ProfileType.water,
              image: Image.asset(Images.water),
              databaseId: databaseId,
              orderNumber: 0,
              properties: _properties
              );
      break;

      case DatabaseIds.barista:   
      return  new Profile(
              updatedAt: DateTime.now(),
              objectId: '',
              type: ProfileType.barista,
              image: Image.asset(Images.user),
              databaseId: databaseId,
              orderNumber: 0,
              properties: _properties
              );
      break;

      default: 

      return  new Profile(
              updatedAt: DateTime.now(),
              objectId: '',
              type: ProfileType.barista,
              image: Image.asset(Images.user),
              databaseId: databaseId,
              orderNumber: 0,
              properties: _properties
              );
      break;
    }
  }
  

static Item createBlankItem(String databaseId){

  Item _item;

    switch (databaseId){

///
/// Recipe
/// 
    case DatabaseIds.date:   
      
      _item = new Item(
        title: StringLabels.date , value: '',
        databaseId: DatabaseIds.date, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.equipmentId:   
      
      _item = new Item(
        title: StringLabels.brewingEquipment , value: '' ,
        databaseId: DatabaseIds.equipmentId, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.grinderId:   
      
      _item = new Item(
        title: StringLabels.grinder , value: '' ,
        databaseId: DatabaseIds.grinderId, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.grindSetting:   
      
      _item = new Item(
        title: StringLabels.grindSetting , value: '' ,
        databaseId: DatabaseIds.grindSetting, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.waterID:   
      
      _item = new Item(
        title: StringLabels.water , value: '' ,
        databaseId: DatabaseIds.waterID, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.temparature:   
      
      _item = new Item(
        title: StringLabels.temparature , value: '' ,
        databaseId: DatabaseIds.temparature, 
        placeHolderText: StringLabels.enterTemparature,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.brewingDose:   
      
      _item = new Item(
        title: StringLabels.brewingDose , value: '' ,
        databaseId: DatabaseIds.brewingDose, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseIds.preinfusion:   
      
      _item = new Item(
        title: StringLabels.preinfusion , value: '' ,
        databaseId: DatabaseIds.preinfusion, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.yield:   
      
      _item = new Item(
        title: StringLabels.yield , value: '' ,
        databaseId: DatabaseIds.yield, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseIds.brewWeight:   
      
      _item = new Item(
        title: StringLabels.brewWeight , value: '' ,
        databaseId: DatabaseIds.brewWeight, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseIds.time:   
      
      _item = new Item(
        title: StringLabels.time , value: '' ,
        databaseId: DatabaseIds.time, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseIds.tds:   
      
      _item = new Item(
        title: StringLabels.tds , value: '' ,
        databaseId: DatabaseIds.tds, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;
      

    case DatabaseIds.notes:   
      
      _item = new Item(
        title: StringLabels.brewingEquipment , value: '' ,
        databaseId: DatabaseIds.date, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.flavour:   
      
      _item = new Item(
        title: StringLabels.flavour , value: '' ,
        databaseId: DatabaseIds.flavour, 
        placeHolderText: StringLabels.flavour,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseIds.body:   
      
      _item = new Item(
        title: StringLabels.body , value: '' ,
        databaseId: DatabaseIds.body, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseIds.balance:   
      
      _item = new Item(
        title: StringLabels.balance , value: '' ,
        databaseId: DatabaseIds.balance, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseIds.afterTaste:   
      
      _item = new Item(
        title: StringLabels.afterTaste , value: '' ,
        databaseId: DatabaseIds.afterTaste, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.descriptors:   
      
      _item = new Item(
        title: StringLabels.descriptors , value: '' ,
        databaseId: DatabaseIds.descriptors, 
        placeHolderText: StringLabels.descriptors,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.coffeeId:   
      
      _item = new Item(
        title: StringLabels.coffee , value: '' ,
        databaseId: DatabaseIds.coffeeId, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;


///
/// Water
/// 

    case DatabaseIds.waterID:   
      
      _item = new Item(
        title: StringLabels.waterID , value: '' ,
        databaseId: DatabaseIds.waterID, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.date:   
      
      _item = new Item(
        title: StringLabels.date , value: '' ,
        databaseId: DatabaseIds.date, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseIds.ppm:   
      
      _item = new Item(
        title: StringLabels.ppm , value: '' ,
        databaseId: DatabaseIds.ppm, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseIds.gh:   
      
      _item = new Item(
        title: StringLabels.gh , value: '' ,
        databaseId: DatabaseIds.gh, 
        placeHolderText: StringLabels.gh,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseIds.kh:   
      
      _item = new Item(
        title: StringLabels.kh , value: '' ,
        databaseId: DatabaseIds.kh, 
        placeHolderText: StringLabels.kh,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseIds.ph:   
      
      _item = new Item(
        title: StringLabels.ph , value: '' ,
        databaseId: DatabaseIds.ph, 
        placeHolderText: StringLabels.ph,
        keyboardType: TextInputType.number,);
      break;


///
/// Coffee
/// 

    case DatabaseIds.region:   
      
      _item = new Item(
        title: StringLabels.region , value: '' ,
        databaseId: DatabaseIds.region, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.farm:   
      
      _item = new Item(
        title: StringLabels.farm , value: '' ,
        databaseId: DatabaseIds.farm, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.producer:   
      
      _item = new Item(
        title: StringLabels.producer , value: '' ,
        databaseId: DatabaseIds.producer, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.lot:   
      
      _item = new Item(
        title: StringLabels.lot , value: '' ,
        databaseId: DatabaseIds.lot, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.altitude:   
      
      _item = new Item(
        title: StringLabels.altitude , value: '' ,
        databaseId: DatabaseIds.altitude, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

/// Roasting details

    case DatabaseIds.roastDate:   
      
      _item = new Item(
        title: StringLabels.roastDate , value: '' ,
        databaseId: DatabaseIds.roastDate, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.roastProfile:   
      
      _item = new Item(
        title: StringLabels.roastProfile , value: '' ,
        databaseId: DatabaseIds.roastProfile, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.roasteryName:   
      
      _item = new Item(
        title: StringLabels.roasteryName , value: '' ,
        databaseId: DatabaseIds.roasteryName, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.beanType:   
      
      _item = new Item(
        title: StringLabels.beanType , value: '' ,
        databaseId: DatabaseIds.beanType, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,
        inputViewDataSet: StringDataArrays.beanType);
      break;

    case DatabaseIds.beanSize:   
      
      _item = new Item(
        title: StringLabels.beanSize , value: '' ,
        databaseId: DatabaseIds.beanSize, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,
        inputViewDataSet: StringDataArrays.beanSize);
      break;

    case DatabaseIds.processingMethod:   
      
      _item = new Item(
        title: StringLabels.processingMethod , value: '' ,
        databaseId: DatabaseIds.processingMethod, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,
        inputViewDataSet: StringDataArrays.processingMethods);
      break;

    case DatabaseIds.density:   
      
      _item = new Item(
        title: StringLabels.density , value: '' ,
        databaseId: DatabaseIds.density, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseIds.aW:   
      
      _item = new Item(
        title: StringLabels.aW , value: '' ,
        databaseId: DatabaseIds.aW, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseIds.moisture:   
      
      _item = new Item(
        title: StringLabels.moisture , value: '' ,
        databaseId: DatabaseIds.moisture, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.number,);
      break;

///
/// Grinder
///
    case DatabaseIds.grinderId:   
      
      _item = new Item(
        title: StringLabels.grinderId , value: '' ,
        databaseId: DatabaseIds.grinderId, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.burrs:   
      
      _item = new Item(
        title: StringLabels.burrs , value: '' ,
        databaseId: DatabaseIds.burrs, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.grinderMake:   
      
      _item = new Item(
        title: StringLabels.grinderMake , value: '' ,
        databaseId: DatabaseIds.grinderMake, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.grinderModel:   
      
      _item = new Item(
        title: StringLabels.grinderModel , value: '' ,
        databaseId: DatabaseIds.grinderModel, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;


///
/// Equipment
///
    case DatabaseIds.equipmentId:   
      
      _item = new Item(
        title: StringLabels.equipmentId , value: '' ,
        databaseId: DatabaseIds.equipmentId, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.equipmentType:   
      
      _item = new Item(
        title: StringLabels.equipmentType , value: '' ,
        databaseId: DatabaseIds.equipmentType, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.equipmentModel:   
      
      _item = new Item(
        title: StringLabels.equipmentModel , value: '' ,
        databaseId: DatabaseIds.equipmentModel, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.method:   
      
      _item = new Item(
        title: StringLabels.method , value: '' ,
        databaseId: DatabaseIds.method, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    default:
      _item = new Item(
        title: StringLabels.method , value: '' ,
        databaseId: DatabaseIds.method, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;
    }

    return _item;
  }


static Item createItemWithData(Map<String, dynamic> item){

   Item _item;

    item.forEach((key,aValue){            

    dynamic value;

    if ( aValue != null ){ value = aValue;} else {value = '';}
    switch (key){

///
/// Recipe
/// 
    case DatabaseIds.date:   
      
      _item = new Item(
        title: StringLabels.date , value: value ,
        databaseId: DatabaseIds.date, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.equipmentId:   
      
      _item = new Item(
        title: StringLabels.brewingEquipment , value: value ,
        databaseId: DatabaseIds.equipmentId, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.grinderId:   
      
      _item = new Item(
        title: StringLabels.grinder , value: value ,
        databaseId: DatabaseIds.grinderId, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.grindSetting:   
      
      _item = new Item(
        title: StringLabels.grindSetting , value: value ,
        databaseId: DatabaseIds.grindSetting, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.waterID:   
      
      _item = new Item(
        title: StringLabels.water , value: value ,
        databaseId: DatabaseIds.waterID, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.temparature:   
      
      _item = new Item(
        title: StringLabels.temparature , value: value ,
        databaseId: DatabaseIds.temparature, 
        placeHolderText: StringLabels.enterTemparature,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.brewingDose:   
      
      _item = new Item(
        title: StringLabels.brewingDose , value: value ,
        databaseId: DatabaseIds.brewingDose, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseIds.preinfusion:   
      
      _item = new Item(
        title: StringLabels.preinfusion , value: value ,
        databaseId: DatabaseIds.preinfusion, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.yield:   
      
      _item = new Item(
        title: StringLabels.yield , value: value ,
        databaseId: DatabaseIds.yield, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseIds.brewWeight:   
      
      _item = new Item(
        title: StringLabels.brewWeight , value: value ,
        databaseId: DatabaseIds.brewWeight, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseIds.time:   
      
      _item = new Item(
        title: StringLabels.time , value: value ,
        databaseId: DatabaseIds.time, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseIds.tds:   
      
      _item = new Item(
        title: StringLabels.tds , value: value ,
        databaseId: DatabaseIds.tds, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;
      

    case DatabaseIds.notes:   
      
      _item = new Item(
        title: StringLabels.brewingEquipment , value: value ,
        databaseId: DatabaseIds.date, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.flavour:   
      
      _item = new Item(
        title: StringLabels.flavour , value: value ,
        databaseId: DatabaseIds.flavour, 
        placeHolderText: StringLabels.flavour,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseIds.body:   
      
      _item = new Item(
        title: StringLabels.body , value: value ,
        databaseId: DatabaseIds.body, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseIds.balance:   
      
      _item = new Item(
        title: StringLabels.balance , value: value ,
        databaseId: DatabaseIds.balance, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseIds.afterTaste:   
      
      _item = new Item(
        title: StringLabels.afterTaste , value: value ,
        databaseId: DatabaseIds.afterTaste, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.descriptors:   
      
      _item = new Item(
        title: StringLabels.descriptors , value: value ,
        databaseId: DatabaseIds.descriptors, 
        placeHolderText: StringLabels.descriptors,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.coffeeId:   
      
      _item = new Item(
        title: StringLabels.coffee , value: value ,
        databaseId: DatabaseIds.coffeeId, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;


///
/// Water
/// 

    case DatabaseIds.waterID:   
      
      _item = new Item(
        title: StringLabels.waterID , value: value ,
        databaseId: DatabaseIds.waterID, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.date:   
      
      _item = new Item(
        title: StringLabels.date , value: value ,
        databaseId: DatabaseIds.date, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseIds.ppm:   
      
      _item = new Item(
        title: StringLabels.ppm , value: value ,
        databaseId: DatabaseIds.ppm, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseIds.gh:   
      
      _item = new Item(
        title: StringLabels.gh , value: value ,
        databaseId: DatabaseIds.gh, 
        placeHolderText: StringLabels.gh,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseIds.kh:   
      
      _item = new Item(
        title: StringLabels.kh , value: value ,
        databaseId: DatabaseIds.kh, 
        placeHolderText: StringLabels.kh,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseIds.ph:   
      
      _item = new Item(
        title: StringLabels.ph , value: value ,
        databaseId: DatabaseIds.ph, 
        placeHolderText: StringLabels.ph,
        keyboardType: TextInputType.number,);
      break;


///
/// Coffee
/// 

    case DatabaseIds.region:   
      
      _item = new Item(
        title: StringLabels.region , value: value ,
        databaseId: DatabaseIds.region, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.farm:   
      
      _item = new Item(
        title: StringLabels.farm , value: value ,
        databaseId: DatabaseIds.farm, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.producer:   
      
      _item = new Item(
        title: StringLabels.producer , value: value ,
        databaseId: DatabaseIds.producer, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.lot:   
      
      _item = new Item(
        title: StringLabels.lot , value: value ,
        databaseId: DatabaseIds.lot, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.altitude:   
      
      _item = new Item(
        title: StringLabels.altitude , value: value ,
        databaseId: DatabaseIds.altitude, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

/// Roasting details

    case DatabaseIds.roastDate:   
      
      _item = new Item(
        title: StringLabels.roastDate , value: value ,
        databaseId: DatabaseIds.roastDate, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.roastProfile:   
      
      _item = new Item(
        title: StringLabels.roastProfile , value: value ,
        databaseId: DatabaseIds.roastProfile, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.roasteryName:   
      
      _item = new Item(
        title: StringLabels.roasteryName , value: value ,
        databaseId: DatabaseIds.roasteryName, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.beanType:   
      
      _item = new Item(
        title: StringLabels.beanType , value: value ,
        databaseId: DatabaseIds.beanType, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,
        inputViewDataSet: StringDataArrays.beanType);
      break;

    case DatabaseIds.beanSize:   
      
      _item = new Item(
        title: StringLabels.beanSize , value: value ,
        databaseId: DatabaseIds.beanSize, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,
        inputViewDataSet: StringDataArrays.beanSize);
      break;

    case DatabaseIds.processingMethod:   
      
      _item = new Item(
        title: StringLabels.processingMethod , value: value ,
        databaseId: DatabaseIds.processingMethod, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,
        inputViewDataSet: StringDataArrays.processingMethods);
      break;

    case DatabaseIds.density:   
      
      _item = new Item(
        title: StringLabels.density , value: value ,
        databaseId: DatabaseIds.density, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseIds.aW:   
      
      _item = new Item(
        title: StringLabels.aW , value: value ,
        databaseId: DatabaseIds.aW, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseIds.moisture:   
      
      _item = new Item(
        title: StringLabels.moisture , value: value ,
        databaseId: DatabaseIds.moisture, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.number,);
      break;

///
/// Grinder
///
    case DatabaseIds.grinderId:   
      
      _item = new Item(
        title: StringLabels.grinderId , value: value ,
        databaseId: DatabaseIds.grinderId, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.burrs:   
      
      _item = new Item(
        title: StringLabels.burrs , value: value ,
        databaseId: DatabaseIds.burrs, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.grinderMake:   
      
      _item = new Item(
        title: StringLabels.grinderMake , value: value ,
        databaseId: DatabaseIds.grinderMake, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.grinderModel:   
      
      _item = new Item(
        title: StringLabels.grinderModel , value: value ,
        databaseId: DatabaseIds.grinderModel, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;


///
/// Equipment
///
    case DatabaseIds.equipmentId:   
      
      _item = new Item(
        title: StringLabels.equipmentId , value: value ,
        databaseId: DatabaseIds.equipmentId, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.equipmentType:   
      
      _item = new Item(
        title: StringLabels.equipmentType , value: value ,
        databaseId: DatabaseIds.equipmentType, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.equipmentModel:   
      
      _item = new Item(
        title: StringLabels.equipmentModel , value: value ,
        databaseId: DatabaseIds.equipmentModel, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseIds.method:   
      
      _item = new Item(
        title: StringLabels.method , value: value ,
        databaseId: DatabaseIds.method, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;
   
    ///
    /// Barista
    ///   
    /// 
    
      case DatabaseIds.level:   
      
      _item = new Item(
        title: StringLabels.level , value: value ,
        databaseId: DatabaseIds.level, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

      case DatabaseIds.name:   
      
      _item = new Item(
        title: StringLabels.name , value: value ,
        databaseId: DatabaseIds.name, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

      case DatabaseIds.age:   
      
      _item = new Item(
        title: StringLabels.age , value: value ,
        databaseId: DatabaseIds.age, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

      default:

        _item = new Item(
          title: StringLabels.method , value: value ,
          databaseId: DatabaseIds.method, 
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,);
        break;

      }
    });
  return  _item;
  } 
}