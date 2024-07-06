part of 'create_patr_bloc.dart';

@immutable
sealed class CreatePatrEvent {}

class CreatePatrPostEvent extends CreatePatrEvent {
  final String content;

  CreatePatrPostEvent(this.content);
}
