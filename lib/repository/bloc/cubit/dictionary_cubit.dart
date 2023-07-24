import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_dictionary_app/model/word_response_model.dart';
import 'package:flutter_application_dictionary_app/repository/service_repo.dart';
import 'package:meta/meta.dart';

part 'dictionary_state.dart';

class DictionaryCubit extends Cubit<DictionaryState> {
  final WordRepository _repository;

  DictionaryCubit(this._repository) : super(DictionaryInitial());

  final queryController = TextEditingController();

  Future getWordSearched() async {
    emit(WordSearchingState());
    try {
      final words =
          await _repository.getWordsfromDictionary(queryController.text);

      if (words == null) {
        emit(WordSearchingErrorState('Field is cannot be empty'));
      } else {
        emit(WordSearchedState(words));
      }
    } catch (e) {
      emit(WordSearchingErrorState('some error appered'));
    }
  }
}
