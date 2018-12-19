import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'dart:async';
import 'dart:io';
import 'dart:math';


class Images{
    
    /// Firebase Images
    static const String coffeeBeansFirebase = 'https://firebasestorage.googleapis.com/v0/b/dial-in-21c50.appspot.com/o/default_images%2Fcoffee-beanSmaller512x512.png?alt=media&token=f9127bcf-11d9-4ba2-bc65-7a15abca2b35';
    static const String userFirebase = 'https://firebasestorage.googleapis.com/v0/b/dial-in-21c50.appspot.com/o/default_images%2Fuser.png?alt=media&token=c2ccceec-8d24-42fe-b5c0-c987733ac8ae';
    static const String aeropressSmaller512x512Firebase = 'https://firebasestorage.googleapis.com/v0/b/dial-in-21c50.appspot.com/o/default_images%2FaeropressSmaller512x512.png?alt=media&token=a3ca2407-78dd-441c-8dd8-a59a90f3f650';
    static const String dropFirebase = 'https://firebasestorage.googleapis.com/v0/b/dial-in-21c50.appspot.com/o/default_images%2Fdrop.png?alt=media&token=b5e4d799-af59-4dc0-9495-becf5900095d';
    static const String recipeSmallerFirebase = 'https://firebasestorage.googleapis.com/v0/b/dial-in-21c50.appspot.com/o/default_images%2FrecipeSmaller512x512.png?alt=media&token=afbd5668-0aaf-42c5-b484-303acd8a705c';
    static const String grinderFirebase = 'https://firebasestorage.googleapis.com/v0/b/dial-in-21c50.appspot.com/o/default_images%2FgrinderSmaller512x512.png?alt=media&token=65a648f6-2014-4fa8-a1ed-16d80a26387a';

    /// Assets
    static const String cherries = 'assets/images/cherries.jpg';
    static const String dialInWhiteLogo = 'assets/images/DialInWhiteLogo.png';
    static const String user = 'assets/images/user.png';
    static const String backIcon = 'assets/images/back_icon.png';
    static const String cherriestwo = 'assets/images/cherriestwo.jpg';
    static const String addProfileButtonWithOrangeTint = 'assets/images/addProfileButtonWithOrangeTint.png';
    static const String logout = 'assets/images/logout.png';
    static const String aeropressSmaller512x512 = 'assets/images/aeropressSmaller512x512.png';
    static const String drop = 'assets/images/drop.png';
    static const String whiteRecipe200X200 = 'assets/images/whiteRecipe200X200.png';
    static const String coffeeBeans = 'assets/images/coffee-beanSmaller512x512.png';
    static const String grinder = 'assets/images/grinderSmaller512x512.png';
    static const String groupHandle = 'assets/images/whiteGrouphandle80x80@2x.png';
    static const String water = 'assets/images/drop.png';
    static const String recipeSmaller = 'assets/images/recipeSmaller512x512.png';
    // static const String recipeSmaller = 'assets/images/recipeSmaller512x512.png';


  static  Future<void> getFile(String filePath, Function(File) completion) async{

    final ByteData bytes = await rootBundle.load(filePath);
    final Directory tempDir = Directory.systemTemp;
    final String fileName = "${Random().nextInt(10000)}.jpg";
    final File file = File('${tempDir.path}/$fileName');
    file.writeAsBytes(bytes.buffer.asInt8List(),mode: FileMode.write);

   completion(file);
  }
}