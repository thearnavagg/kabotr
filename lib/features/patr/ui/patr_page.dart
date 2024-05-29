import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kabotr/features/create_patr/ui/create_patr_page.dart';
import 'package:kabotr/features/patr/bloc/patr_bloc.dart';
import 'package:intl/intl.dart';


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
      floatingActionButton: FloatingActionButton(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: BlocConsumer<PatrBloc, PatrState>(
        bloc: patrBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case PatrsSuccessState:
              final successState = state as PatrsSuccessState;
              return Container(
                margin: const EdgeInsets.only(top: 60),
                child: Column(
                  children: [
                    // LOGO

                    const Center(child: FlutterLogo()), // TO-DO: to edit this

                    // TWEETS
                    Expanded(
                        child: ListView.separated(
                      itemCount: successState.patrs.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 32,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                successState.patrs[index].patr.content,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Patred by: ${successState
                                            .patrs[index].admin.firstName} ${successState
                                            .patrs[index].admin.lastNAme}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    DateFormat("dd MMMM yyyy hh:mm a").format(
                                        successState
                                            .patrs[index].patr.createdAt),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ))
                  ],
                ),
              );

            case PatrsLoadState:
              return const Center(child: CircularProgressIndicator());
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
