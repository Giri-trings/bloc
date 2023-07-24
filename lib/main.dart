import 'package:flutter/material.dart';
import 'package:flutter_application_dictionary_app/presentation/home_page.dart';
import 'package:flutter_application_dictionary_app/repository/bloc/cubit/dictionary_cubit.dart';
import 'package:flutter_application_dictionary_app/repository/service_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => DictionaryCubit(WordRepository()),
        child: const HomePage(),
      ),
    );
  }
}
