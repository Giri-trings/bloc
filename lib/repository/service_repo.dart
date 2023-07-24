

import 'package:flutter_application_dictionary_app/model/word_response_model.dart';

import '../domain/service.dart';

class WordRepository {
  Future<List<WordResponseModel>?> getWordsfromDictionary(String query) async {
    try {
      final response = await HttpService.getRequest('en/$query');
      if (response.statusCode == 200) {
        final result = wordResponseModelFromJson(response.body);
        return result;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
