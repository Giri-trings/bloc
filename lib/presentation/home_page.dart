import 'package:flutter/material.dart';
import 'package:flutter_application_dictionary_app/presentation/list_screen.dart';
import 'package:flutter_application_dictionary_app/repository/bloc/cubit/dictionary_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DictionaryCubit cubit;
  bool showErrorDialog = false;

  @override
  void initState() {
    cubit = context.read<DictionaryCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade800,
      body: BlocConsumer<DictionaryCubit, DictionaryState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is WordSearchedState && state.words != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListScreen(words: state.words),
              ),
            );
          } else if (state is WordSearchingErrorState) {
            setState(() {
              showErrorDialog = true;
            });
          }
        },
        builder: (context, state) {
          if (state is WordSearchingState) {
            return getLoadingWidget();
          } else if (state is DictionaryInitial) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Spacer(),
                  _appNameTextWidget(),
                  const SizedBox(
                    height: 32,
                  ),
                  TextField(
                    controller: cubit.queryController,
                    decoration: InputDecoration(
                      hintText: "Search a word",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      fillColor: Colors.grey[100],
                      filled: true,
                      prefixIcon: const Icon(Icons.search),
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        cubit.getWordSearched();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrangeAccent,
                          padding: const EdgeInsets.all(16)),
                      child: const Text("SEARCH"),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _appNameTextWidget() {
    return Column(
      children: const [
        Text(
          "Dictionary App",
          style: TextStyle(
            color: Colors.deepOrangeAccent,
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Search any word you want quickly",
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget getLoadingWidget() {
    return const Center(child: CircularProgressIndicator());
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  Widget getErrorWidget(BuildContext context) {
    if (showErrorDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text("Error"),
            content: const Text("An error occurred."),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      });
      showErrorDialog = false;
    }

    return Container();
  }
}
