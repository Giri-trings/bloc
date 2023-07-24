import 'package:flutter/material.dart';

import 'package:flutter_application_dictionary_app/model/word_response_model.dart';
import 'package:flutter_application_dictionary_app/presentation/detail_screen.dart';

class ListScreen extends StatelessWidget {
  final List<WordResponseModel> words;

  const ListScreen({super.key, required this.words});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade800,
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                "${index + 1}. ${words[index].word}",
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailScreen(
                              wordResponse: words[index],
                            )));
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
              ),
          itemCount: words.length),
    );
  }
}
