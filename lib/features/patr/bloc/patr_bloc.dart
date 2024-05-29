import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:kabotr/features/patr/models/patr_model.dart';
import 'package:kabotr/features/patr/repos/patr_repo.dart';
import 'package:meta/meta.dart';

part 'patr_event.dart';
part 'patr_state.dart';

class PatrBloc extends Bloc<PatrEvent, PatrState> {
  PatrBloc() : super(PatrInitial()) {
    on<PatrInitialFetchEvent>(patrInitialFetchEvent);
  }

  FutureOr<void> patrInitialFetchEvent(
      PatrInitialFetchEvent event, Emitter<PatrState> emit) async {
    emit(PatrsLoadState());
    List<PatrModel> patrs = await PatrRepo.getAllPatrs();
    emit(PatrsSuccessState(patrs: patrs));
  }
}
