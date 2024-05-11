import 'colorConverter.dart';

class AppwriteConstant {
  static const String endpoint = 'https://appwrite-fp.hftm.bernerbros.ch';
  static const String projectID = '662bd62e002f2d720896';
  static const String collectionID = '663fcea00038bfe17d54';

}

class HexColors {
  static final primaryColor = createMaterialColor('#333333');
  static final secondColor = createMaterialColor('#666666');
  static final tertiaryColor = createMaterialColor('#00ADC8');
  static final quaternaryColor = createMaterialColor('#FFFFFF');
}

class RoutesPaths {
  static const String login = '/login';
  static const String home = '/home';
  static const String root = '/';
  static const String machine_planning = '/machine-planning';
}

class ImagePaths {
  static const String logo = 'assets/images/logo/20_Logo_Transparent.png';
}

class HiveTypeIds {
  static const int machineCardDto = 0;
}