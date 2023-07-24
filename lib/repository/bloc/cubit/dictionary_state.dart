part of 'dictionary_cubit.dart';

@immutable
abstract class DictionaryState {}

class DictionaryInitial extends DictionaryState {}

class WordSearchingState extends DictionaryState {}

class WordSearchedState extends DictionaryState {
  final List<WordResponseModel> words;

  WordSearchedState(this.words);
}

class WordSearchingErrorState extends DictionaryState {
  final String message;

  WordSearchingErrorState(this.message);
  
}
