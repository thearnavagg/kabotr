import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_patr_event.dart';
part 'update_patr_state.dart';

class UpdatePatrBloc extends Bloc<UpdatePatrEvent, UpdatePatrState> {
  UpdatePatrBloc() : super(UpdatePatrInitial()) {
    on<UpdatePatrEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
