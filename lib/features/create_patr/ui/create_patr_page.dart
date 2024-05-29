import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kabotr/features/create_patr/bloc/create_patr_bloc.dart';
import 'package:kabotr/features/patr/bloc/patr_bloc.dart';


class CreatePatrPage extends StatefulWidget {
  final PatrBloc patrBloc;
  const CreatePatrPage({super.key, required this.patrBloc});

  @override
  State<CreatePatrPage> createState() => _CreatePatrPageState();
}

class _CreatePatrPageState extends State<CreatePatrPage> {
  TextEditingController contentController = TextEditingController();
  bool loader = false;

  CreatePatrBloc createPatrBloc = CreatePatrBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CreatePatrBloc, CreatePatrState>(
        bloc: createPatrBloc,
        listenWhen: (previous, current) => current is CreatePatrActionState,
        buildWhen: (previous, current) => current is! CreatePatrActionState,
        listener: (context, state) {
          if (state is CreatePatrLoadingState) {
            setState(() {
              loader = true;
            });
          } else if (state is CreatePatrSuccessState) {
            widget.patrBloc.add(PatrInitialFetchEvent());
            setState(() {
              loader = false;
            });
            Navigator.pop(context);
          } else if (state is CreatePatrErrorState) {
            setState(() {
              loader = false;
            });
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Something went wrong")));
          }
        },
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.only(top: 80, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Create Patr",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: contentController,
                  maxLines: 30,
                  minLines: 1,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Write whats in your mind🤯",
                    hintStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                    height: 48,
                    width: double.maxFinite,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: () {
                          createPatrBloc.add(
                              CreatePatrPostEvent(contentController.text));
                        },
                        child: const Text(
                          "POST",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )))
              ],
            ),
          );
        },
      ),
    );
  }
}
