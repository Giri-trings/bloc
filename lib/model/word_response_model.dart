// To parse this JSON data, do
//
//     final wordResponseModel = wordResponseModelFromJson(jsonString);

import 'dart:convert';

List<WordResponseModel> wordResponseModelFromJson(String str) => List<WordResponseModel>.from(json.decode(str).map((x) => WordResponseModel.fromJson(x)));

String wordResponseModelToJson(List<WordResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WordResponseModel {
    final String? word;
    final String? phonetic;
    final List<Phonetic>? phonetics;
    final String? origin;
    final List<Meaning>? meanings;

    WordResponseModel({
        this.word,
        this.phonetic,
        this.phonetics,
        this.origin,
        this.meanings,
    });

    factory WordResponseModel.fromJson(Map<String, dynamic> json) => WordResponseModel(
        word: json["word"],
        phonetic: json["phonetic"],
        phonetics: json["phonetics"] == null ? [] : List<Phonetic>.from(json["phonetics"]!.map((x) => Phonetic.fromJson(x))),
        origin: json["origin"],
        meanings: json["meanings"] == null ? [] : List<Meaning>.from(json["meanings"]!.map((x) => Meaning.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "word": word,
        "phonetic": phonetic,
        "phonetics": phonetics == null ? [] : List<dynamic>.from(phonetics!.map((x) => x.toJson())),
        "origin": origin,
        "meanings": meanings == null ? [] : List<dynamic>.from(meanings!.map((x) => x.toJson())),
    };
}

class Meaning {
    final String? partOfSpeech;
    final List<Definition>? definitions;

    Meaning({
        this.partOfSpeech,
        this.definitions,
    });

    factory Meaning.fromJson(Map<String, dynamic> json) => Meaning(
        partOfSpeech: json["partOfSpeech"],
        definitions: json["definitions"] == null ? [] : List<Definition>.from(json["definitions"]!.map((x) => Definition.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "partOfSpeech": partOfSpeech,
        "definitions": definitions == null ? [] : List<dynamic>.from(definitions!.map((x) => x.toJson())),
    };
}

class Definition {
    final String? definition;
    final String? example;
    final List<dynamic>? synonyms;
    final List<dynamic>? antonyms;

    Definition({
        this.definition,
        this.example,
        this.synonyms,
        this.antonyms,
    });

    factory Definition.fromJson(Map<String, dynamic> json) => Definition(
        definition: json["definition"],
        example: json["example"],
        synonyms: json["synonyms"] == null ? [] : List<dynamic>.from(json["synonyms"]!.map((x) => x)),
        antonyms: json["antonyms"] == null ? [] : List<dynamic>.from(json["antonyms"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "definition": definition,
        "example": example,
        "synonyms": synonyms == null ? [] : List<dynamic>.from(synonyms!.map((x) => x)),
        "antonyms": antonyms == null ? [] : List<dynamic>.from(antonyms!.map((x) => x)),
    };
}

class Phonetic {
    final String? text;
    final String? audio;

    Phonetic({
        this.text,
        this.audio,
    });

    factory Phonetic.fromJson(Map<String, dynamic> json) => Phonetic(
        text: json["text"],
        audio: json["audio"],
    );

    Map<String, dynamic> toJson() => {
        "text": text,
        "audio": audio,
    };
}
