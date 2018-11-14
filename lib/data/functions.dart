import 'item.dart';
import '../database_functions.dart';
import 'strings.dart';
import 'package:flutter/material.dart';
import 'profile.dart';
import 'images.dart';



class Functions{

  // static Profile createBlankProfile(ProfileType profileType){
  //   switch(profileType){

  //     case ProfileType.recipe:   
    
  //     return  new Profile(
  //             updatedAt: DateTime.now(),
  //             objectId: '',
  //             // image: document[DatabaseFunctions.image].toString(),
  //             databaseId: DatabaseFunctions.databaseId,
  //             orderNumber: 0,
  //             properties: pr
  //             );
        
  //     break;
  //   }
  // }


  static Profile createProfile(String databaseId, List<Item> _properties){
    
    switch(databaseId){

      case DatabaseFunctions.recipe:   
      return  new Profile(
              updatedAt: DateTime.now(),
              objectId: '',
              type: ProfileType.recipe,
              image: Image.asset(Images.whiteRecipe200X200),
              databaseId: databaseId,
              orderNumber: 0,
              properties: _properties
              );
      break;

      case DatabaseFunctions.coffee:   
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

      case DatabaseFunctions.grinder:   
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

      case DatabaseFunctions.brewingEquipment:   
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

      case DatabaseFunctions.water:   
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

      case DatabaseFunctions.barista:   
      return  new Profile(
              updatedAt: DateTime.now(),
              objectId: '',
              type: ProfileType.barista,
              // image: document[DatabaseFunctions.image].toString(),
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
              // image: document[DatabaseFunctions.image].toString(),
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
    case DatabaseFunctions.date:   
      
      _item = new Item(
        title: StringLabels.date , value: '',
        databaseId: DatabaseFunctions.date, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.equipmentId:   
      
      _item = new Item(
        title: StringLabels.brewingEquipment , value: '' ,
        databaseId: DatabaseFunctions.equipmentId, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.grinderId:   
      
      _item = new Item(
        title: StringLabels.grinder , value: '' ,
        databaseId: DatabaseFunctions.grinderId, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.grindSetting:   
      
      _item = new Item(
        title: StringLabels.grindSetting , value: '' ,
        databaseId: DatabaseFunctions.grindSetting, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.waterID:   
      
      _item = new Item(
        title: StringLabels.water , value: '' ,
        databaseId: DatabaseFunctions.waterID, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.temparature:   
      
      _item = new Item(
        title: StringLabels.temparature , value: '' ,
        databaseId: DatabaseFunctions.temparature, 
        placeHolderText: StringLabels.enterTemparature,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.brewingDose:   
      
      _item = new Item(
        title: StringLabels.brewingDose , value: '' ,
        databaseId: DatabaseFunctions.brewingDose, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.preinfusion:   
      
      _item = new Item(
        title: StringLabels.preinfusion , value: '' ,
        databaseId: DatabaseFunctions.preinfusion, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.yield:   
      
      _item = new Item(
        title: StringLabels.yield , value: '' ,
        databaseId: DatabaseFunctions.yield, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.brewWeight:   
      
      _item = new Item(
        title: StringLabels.brewWeight , value: '' ,
        databaseId: DatabaseFunctions.brewWeight, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.time:   
      
      _item = new Item(
        title: StringLabels.time , value: '' ,
        databaseId: DatabaseFunctions.time, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.tds:   
      
      _item = new Item(
        title: StringLabels.tds , value: '' ,
        databaseId: DatabaseFunctions.tds, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;
      

    case DatabaseFunctions.notes:   
      
      _item = new Item(
        title: StringLabels.brewingEquipment , value: '' ,
        databaseId: DatabaseFunctions.date, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.flavour:   
      
      _item = new Item(
        title: StringLabels.flavour , value: '' ,
        databaseId: DatabaseFunctions.flavour, 
        placeHolderText: StringLabels.flavour,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.body:   
      
      _item = new Item(
        title: StringLabels.body , value: '' ,
        databaseId: DatabaseFunctions.body, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.balance:   
      
      _item = new Item(
        title: StringLabels.balance , value: '' ,
        databaseId: DatabaseFunctions.balance, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.afterTaste:   
      
      _item = new Item(
        title: StringLabels.afterTaste , value: '' ,
        databaseId: DatabaseFunctions.afterTaste, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.descriptors:   
      
      _item = new Item(
        title: StringLabels.descriptors , value: '' ,
        databaseId: DatabaseFunctions.descriptors, 
        placeHolderText: StringLabels.descriptors,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.coffeeId:   
      
      _item = new Item(
        title: StringLabels.coffee , value: '' ,
        databaseId: DatabaseFunctions.coffeeId, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;


///
/// Water
/// 

    case DatabaseFunctions.waterID:   
      
      _item = new Item(
        title: StringLabels.waterID , value: '' ,
        databaseId: DatabaseFunctions.waterID, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.date:   
      
      _item = new Item(
        title: StringLabels.date , value: '' ,
        databaseId: DatabaseFunctions.date, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.ppm:   
      
      _item = new Item(
        title: StringLabels.ppm , value: '' ,
        databaseId: DatabaseFunctions.ppm, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.gh:   
      
      _item = new Item(
        title: StringLabels.gh , value: '' ,
        databaseId: DatabaseFunctions.gh, 
        placeHolderText: StringLabels.gh,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.kh:   
      
      _item = new Item(
        title: StringLabels.kh , value: '' ,
        databaseId: DatabaseFunctions.kh, 
        placeHolderText: StringLabels.kh,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.ph:   
      
      _item = new Item(
        title: StringLabels.ph , value: '' ,
        databaseId: DatabaseFunctions.ph, 
        placeHolderText: StringLabels.ph,
        keyboardType: TextInputType.number,);
      break;


///
/// Coffee
/// 

    case DatabaseFunctions.region:   
      
      _item = new Item(
        title: StringLabels.region , value: '' ,
        databaseId: DatabaseFunctions.region, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.farm:   
      
      _item = new Item(
        title: StringLabels.farm , value: '' ,
        databaseId: DatabaseFunctions.farm, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.producer:   
      
      _item = new Item(
        title: StringLabels.producer , value: '' ,
        databaseId: DatabaseFunctions.producer, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.lot:   
      
      _item = new Item(
        title: StringLabels.lot , value: '' ,
        databaseId: DatabaseFunctions.lot, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.altitude:   
      
      _item = new Item(
        title: StringLabels.altitude , value: '' ,
        databaseId: DatabaseFunctions.altitude, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

/// Roasting details

    case DatabaseFunctions.roastDate:   
      
      _item = new Item(
        title: StringLabels.roastDate , value: '' ,
        databaseId: DatabaseFunctions.roastDate, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.roastProfile:   
      
      _item = new Item(
        title: StringLabels.roastProfile , value: '' ,
        databaseId: DatabaseFunctions.roastProfile, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.roasteryName:   
      
      _item = new Item(
        title: StringLabels.roasteryName , value: '' ,
        databaseId: DatabaseFunctions.roasteryName, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.beanType:   
      
      _item = new Item(
        title: StringLabels.beanType , value: '' ,
        databaseId: DatabaseFunctions.beanType, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,
        inputViewDataSet: StringDataArrays.beanType);
      break;

    case DatabaseFunctions.beanSize:   
      
      _item = new Item(
        title: StringLabels.beanSize , value: '' ,
        databaseId: DatabaseFunctions.beanSize, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,
        inputViewDataSet: StringDataArrays.beanSize);
      break;

    case DatabaseFunctions.processingMethod:   
      
      _item = new Item(
        title: StringLabels.processingMethod , value: '' ,
        databaseId: DatabaseFunctions.processingMethod, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,
        inputViewDataSet: StringDataArrays.processingMethods);
      break;

    case DatabaseFunctions.density:   
      
      _item = new Item(
        title: StringLabels.density , value: '' ,
        databaseId: DatabaseFunctions.density, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.aW:   
      
      _item = new Item(
        title: StringLabels.aW , value: '' ,
        databaseId: DatabaseFunctions.aW, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.moisture:   
      
      _item = new Item(
        title: StringLabels.moisture , value: '' ,
        databaseId: DatabaseFunctions.moisture, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.number,);
      break;

///
/// Grinder
///
    case DatabaseFunctions.grinderId:   
      
      _item = new Item(
        title: StringLabels.grinderId , value: '' ,
        databaseId: DatabaseFunctions.grinderId, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.burrs:   
      
      _item = new Item(
        title: StringLabels.burrs , value: '' ,
        databaseId: DatabaseFunctions.burrs, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.grinderMake:   
      
      _item = new Item(
        title: StringLabels.grinderMake , value: '' ,
        databaseId: DatabaseFunctions.grinderMake, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.grinderModel:   
      
      _item = new Item(
        title: StringLabels.grinderModel , value: '' ,
        databaseId: DatabaseFunctions.grinderModel, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;


///
/// Equipment
///
    case DatabaseFunctions.equipmentId:   
      
      _item = new Item(
        title: StringLabels.equipmentId , value: '' ,
        databaseId: DatabaseFunctions.equipmentId, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.equipmentType:   
      
      _item = new Item(
        title: StringLabels.equipmentType , value: '' ,
        databaseId: DatabaseFunctions.equipmentType, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.equipmentModel:   
      
      _item = new Item(
        title: StringLabels.equipmentModel , value: '' ,
        databaseId: DatabaseFunctions.equipmentModel, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.method:   
      
      _item = new Item(
        title: StringLabels.method , value: '' ,
        databaseId: DatabaseFunctions.method, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    default:
      _item = new Item(
        title: StringLabels.method , value: '' ,
        databaseId: DatabaseFunctions.method, 
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
    case DatabaseFunctions.date:   
      
      _item = new Item(
        title: StringLabels.date , value: value ,
        databaseId: DatabaseFunctions.date, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.equipmentId:   
      
      _item = new Item(
        title: StringLabels.brewingEquipment , value: value ,
        databaseId: DatabaseFunctions.equipmentId, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.grinderId:   
      
      _item = new Item(
        title: StringLabels.grinder , value: value ,
        databaseId: DatabaseFunctions.grinderId, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.grindSetting:   
      
      _item = new Item(
        title: StringLabels.grindSetting , value: value ,
        databaseId: DatabaseFunctions.grindSetting, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.waterID:   
      
      _item = new Item(
        title: StringLabels.water , value: value ,
        databaseId: DatabaseFunctions.waterID, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.temparature:   
      
      _item = new Item(
        title: StringLabels.temparature , value: value ,
        databaseId: DatabaseFunctions.temparature, 
        placeHolderText: StringLabels.enterTemparature,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.brewingDose:   
      
      _item = new Item(
        title: StringLabels.brewingDose , value: value ,
        databaseId: DatabaseFunctions.brewingDose, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.preinfusion:   
      
      _item = new Item(
        title: StringLabels.preinfusion , value: value ,
        databaseId: DatabaseFunctions.preinfusion, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.yield:   
      
      _item = new Item(
        title: StringLabels.yield , value: value ,
        databaseId: DatabaseFunctions.yield, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.brewWeight:   
      
      _item = new Item(
        title: StringLabels.brewWeight , value: value ,
        databaseId: DatabaseFunctions.brewWeight, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.time:   
      
      _item = new Item(
        title: StringLabels.time , value: value ,
        databaseId: DatabaseFunctions.time, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.tds:   
      
      _item = new Item(
        title: StringLabels.tds , value: value ,
        databaseId: DatabaseFunctions.tds, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;
      

    case DatabaseFunctions.notes:   
      
      _item = new Item(
        title: StringLabels.brewingEquipment , value: value ,
        databaseId: DatabaseFunctions.date, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.flavour:   
      
      _item = new Item(
        title: StringLabels.flavour , value: value ,
        databaseId: DatabaseFunctions.flavour, 
        placeHolderText: StringLabels.flavour,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.body:   
      
      _item = new Item(
        title: StringLabels.body , value: value ,
        databaseId: DatabaseFunctions.body, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.balance:   
      
      _item = new Item(
        title: StringLabels.balance , value: value ,
        databaseId: DatabaseFunctions.balance, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.afterTaste:   
      
      _item = new Item(
        title: StringLabels.afterTaste , value: value ,
        databaseId: DatabaseFunctions.afterTaste, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.descriptors:   
      
      _item = new Item(
        title: StringLabels.descriptors , value: value ,
        databaseId: DatabaseFunctions.descriptors, 
        placeHolderText: StringLabels.descriptors,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.coffeeId:   
      
      _item = new Item(
        title: StringLabels.coffee , value: value ,
        databaseId: DatabaseFunctions.coffeeId, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;


///
/// Water
/// 

    case DatabaseFunctions.waterID:   
      
      _item = new Item(
        title: StringLabels.waterID , value: value ,
        databaseId: DatabaseFunctions.waterID, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.date:   
      
      _item = new Item(
        title: StringLabels.date , value: value ,
        databaseId: DatabaseFunctions.date, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.ppm:   
      
      _item = new Item(
        title: StringLabels.ppm , value: value ,
        databaseId: DatabaseFunctions.ppm, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.gh:   
      
      _item = new Item(
        title: StringLabels.gh , value: value ,
        databaseId: DatabaseFunctions.gh, 
        placeHolderText: StringLabels.gh,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.kh:   
      
      _item = new Item(
        title: StringLabels.kh , value: value ,
        databaseId: DatabaseFunctions.kh, 
        placeHolderText: StringLabels.kh,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.ph:   
      
      _item = new Item(
        title: StringLabels.ph , value: value ,
        databaseId: DatabaseFunctions.ph, 
        placeHolderText: StringLabels.ph,
        keyboardType: TextInputType.number,);
      break;


///
/// Coffee
/// 

    case DatabaseFunctions.region:   
      
      _item = new Item(
        title: StringLabels.region , value: value ,
        databaseId: DatabaseFunctions.region, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.farm:   
      
      _item = new Item(
        title: StringLabels.farm , value: value ,
        databaseId: DatabaseFunctions.farm, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.producer:   
      
      _item = new Item(
        title: StringLabels.producer , value: value ,
        databaseId: DatabaseFunctions.producer, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.lot:   
      
      _item = new Item(
        title: StringLabels.lot , value: value ,
        databaseId: DatabaseFunctions.lot, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.altitude:   
      
      _item = new Item(
        title: StringLabels.altitude , value: value ,
        databaseId: DatabaseFunctions.altitude, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

/// Roasting details

    case DatabaseFunctions.roastDate:   
      
      _item = new Item(
        title: StringLabels.roastDate , value: value ,
        databaseId: DatabaseFunctions.roastDate, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.roastProfile:   
      
      _item = new Item(
        title: StringLabels.roastProfile , value: value ,
        databaseId: DatabaseFunctions.roastProfile, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.roasteryName:   
      
      _item = new Item(
        title: StringLabels.roasteryName , value: value ,
        databaseId: DatabaseFunctions.roasteryName, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.beanType:   
      
      _item = new Item(
        title: StringLabels.beanType , value: value ,
        databaseId: DatabaseFunctions.beanType, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,
        inputViewDataSet: StringDataArrays.beanType);
      break;

    case DatabaseFunctions.beanSize:   
      
      _item = new Item(
        title: StringLabels.beanSize , value: value ,
        databaseId: DatabaseFunctions.beanSize, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,
        inputViewDataSet: StringDataArrays.beanSize);
      break;

    case DatabaseFunctions.processingMethod:   
      
      _item = new Item(
        title: StringLabels.processingMethod , value: value ,
        databaseId: DatabaseFunctions.processingMethod, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,
        inputViewDataSet: StringDataArrays.processingMethods);
      break;

    case DatabaseFunctions.density:   
      
      _item = new Item(
        title: StringLabels.density , value: value ,
        databaseId: DatabaseFunctions.density, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.aW:   
      
      _item = new Item(
        title: StringLabels.aW , value: value ,
        databaseId: DatabaseFunctions.aW, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.moisture:   
      
      _item = new Item(
        title: StringLabels.moisture , value: value ,
        databaseId: DatabaseFunctions.moisture, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.number,);
      break;

///
/// Grinder
///
    case DatabaseFunctions.grinderId:   
      
      _item = new Item(
        title: StringLabels.grinderId , value: value ,
        databaseId: DatabaseFunctions.grinderId, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.burrs:   
      
      _item = new Item(
        title: StringLabels.burrs , value: value ,
        databaseId: DatabaseFunctions.burrs, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.grinderMake:   
      
      _item = new Item(
        title: StringLabels.grinderMake , value: value ,
        databaseId: DatabaseFunctions.grinderMake, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.grinderModel:   
      
      _item = new Item(
        title: StringLabels.grinderModel , value: value ,
        databaseId: DatabaseFunctions.grinderModel, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;


///
/// Equipment
///
    case DatabaseFunctions.equipmentId:   
      
      _item = new Item(
        title: StringLabels.equipmentId , value: value ,
        databaseId: DatabaseFunctions.equipmentId, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.equipmentType:   
      
      _item = new Item(
        title: StringLabels.equipmentType , value: value ,
        databaseId: DatabaseFunctions.equipmentType, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.equipmentModel:   
      
      _item = new Item(
        title: StringLabels.equipmentModel , value: value ,
        databaseId: DatabaseFunctions.equipmentModel, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.method:   
      
      _item = new Item(
        title: StringLabels.method , value: value ,
        databaseId: DatabaseFunctions.method, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;
   
    ///
    /// Barista
    ///   
    /// 
    
      case DatabaseFunctions.level:   
      
      _item = new Item(
        title: StringLabels.level , value: value ,
        databaseId: DatabaseFunctions.level, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

      case DatabaseFunctions.name:   
      
      _item = new Item(
        title: StringLabels.name , value: value ,
        databaseId: DatabaseFunctions.name, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

      case DatabaseFunctions.age:   
      
      _item = new Item(
        title: StringLabels.age , value: value ,
        databaseId: DatabaseFunctions.age, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

      default:

        _item = new Item(
          title: StringLabels.method , value: value ,
          databaseId: DatabaseFunctions.method, 
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,);
        break;

      }
    });
  return  _item;
  } 
}