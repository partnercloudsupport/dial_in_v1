import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'dart:async';
import 'dart:io';
import 'dart:math';


class Images{

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
    static const String beanSmaller512x512 = 'images/coffee-beanSmaller512x512.png';
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