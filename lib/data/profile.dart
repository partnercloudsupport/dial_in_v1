import 'strings.dart';
import 'package:flutter/material.dart';
import 'item.dart';



class Profile{

     DateTime updatedAt;
     String objectId; 
     String databaseId;
     List<Item> properties;
     Image image;
     ProfileType type;
     String viewContollerId; 
     int referanceNumber; 
     int orderNumber; 
    
    // Is it water , coffee, grinder , machine etc?
    
    Profile({
      @required 
        this.updatedAt,
        this.objectId,
        this.type,
        this.properties,
        this.image,
        this.databaseId,
        this.viewContollerId,
        this.orderNumber,
        }
    ){
        switch (type) {
            
        case ProfileType.recipe:
            
            this.referanceNumber = 0;
            break;

        case ProfileType.coffee:
            
            this.referanceNumber  = 1;
                        break;

        case ProfileType.grinder:
            
            this.referanceNumber  = 2;
                        break;

        case ProfileType.equipment:
            
            this.referanceNumber  = 3;
                        break;
   
        case ProfileType.water:
            
            this.referanceNumber  = 4;
                        break;

        case ProfileType.barista:
            
            this.referanceNumber  = 5;
                        break;

            
        default:
            
            break;
      }
  }
}  

enum ProfileType{

  recipe, coffee, water, grinder, equipment, barista

}
