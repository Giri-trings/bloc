import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpService {
  static final baseUrl = 'https://api.dictionaryapi.dev/api/v2/entries/';

  static Future<http.Response> getRequest(endPoint) async {
    http.Response response;

    final url = Uri.parse('$baseUrl$endPoint');
    try {
      response = await http.get(url);
    } catch (e) {
      rethrow;
    }
    return response;
  }
}
