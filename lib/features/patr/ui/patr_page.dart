import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kabotr/features/create_patr/ui/create_patr_page.dart';
import 'package:kabotr/features/patr/bloc/patr_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kabotr/themes/app_images.dart';
import 'package:kabotr/themes/splash_screen.dart';


class PatrPage extends StatefulWidget {
  const PatrPage({super.key});

  @override
  State<PatrPage> createState() => _PatrPageState();
}

class _PatrPageState extends State<PatrPage> {
  PatrBloc patrBloc = PatrBloc();

  @override
  void initState() {
    patrBloc.add(PatrInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreatePatrPage(
                          patrBloc: patrBloc,
                        )));
          },
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: BlocConsumer<PatrBloc, PatrState>(
        bloc: patrBloc,
        listener: (context, state) {
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case PatrsSuccessState:
              final successState = state as PatrsSuccessState;
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Center(child: PatrPageLogo()),
                      Expanded(
                        child: ListView.separated(
                          itemCount: successState.patrs.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            int reverseIndex =
                                successState.patrs.length - 1 - index;
                            return Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      successState
                                          .patrs[reverseIndex].patrs.content,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Patred by: ${successState.patrs[reverseIndex].admin.firstName} ${successState.patrs[reverseIndex].admin.lastName}",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          DateFormat("dd MMM yyyy, hh:mm a")
                                              .format(
                                            successState.patrs[reverseIndex].patrs
                                                .createdAt,
                                          ),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );

            case PatrsLoadState:
              return const Center(child: SplashScreen());
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
