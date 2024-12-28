import 'package:flutter_dotenv/flutter_dotenv.dart';

class BaseUrl {
  static final String baseUrl =
      dotenv.env['serverUrl'] ?? 'http://localhost:3000';
}
