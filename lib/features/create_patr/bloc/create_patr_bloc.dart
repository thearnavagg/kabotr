import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kabotr/features/create_patr/repos/create_patr_repo.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'create_patr_event.dart';
part 'create_patr_state.dart';

class CreatePatrBloc extends Bloc<CreatePatrEvent, CreatePatrState> {
  CreatePatrBloc() : super(CreatePatrInitial()) {
    on<CreatePatrPostEvent>(createPatrPostEvent);
  }

  FutureOr<void> createPatrPostEvent(
      CreatePatrPostEvent event, Emitter<CreatePatrState> emit) async {
    emit(CreatePatrLoadingState());
    String currUserId = FirebaseAuth.instance.currentUser?.uid ?? "";
    final uuid = const Uuid().v1();
    bool success = await CreatePatrRepo.postPatrRepo(
        uuid, currUserId, event.content, DateTime.now());
    if (success) {
      emit(CreatePatrSuccessState());
    } else {
      emit(CreatePatrErrorState());
    }
  }
}
