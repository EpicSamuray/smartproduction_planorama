import 'colorConverter.dart';

class AppwriteConstant {
  static const String endpoint = 'https://appwrite-fp.hftm.bernerbros.ch';
  static const String projectID = '662bd62e002f2d720896';
  static const String collectionID = '6640ccfe0027cd313d77';
  static const String databaseID = '6640ccf5001b247ddb0e';
}

enum AppwriteBucket {
  machineImages('663fcea00038bfe17d54');

  const AppwriteBucket(this.value);
  final String value;
}

enum AppwriteCollections {
  machineRessource('6640ccfe0027cd313d77');

  const AppwriteCollections(this.value);
  final String value;
}

class HexColors {
  static final primaryColor = createMaterialColor('#333333');
  static final secondColor = createMaterialColor('#666666');
  static final tertiaryColor = createMaterialColor('#00ADC8');
  static final quaternaryColor = createMaterialColor('#FFFFFF');
  static final whiteShadow = createMaterialColor('#474747');
  static final blackShadow = createMaterialColor('#1F1F1F');
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
