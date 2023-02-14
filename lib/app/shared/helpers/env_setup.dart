import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvSetup {
  static init() async {
    await dotenv.load(fileName: ".env");
  }
}
