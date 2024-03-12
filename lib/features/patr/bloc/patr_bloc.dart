import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'patr_event.dart';
part 'patr_state.dart';

class PatrBloc extends Bloc<PatrEvent, PatrState> {
  PatrBloc() : super(PatrInitial()) {
    on<PatrEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
