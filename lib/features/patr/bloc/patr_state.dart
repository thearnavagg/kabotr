part of 'patr_bloc.dart';

@immutable
sealed class PatrState {}

final class PatrInitial extends PatrState {}

class PatrsLoadState extends PatrState {}

class PatrsSuccessState extends PatrState {
  final List<PatrModel> patrs;
  PatrsSuccessState({
    required this.patrs,
  });
}

class PatrsErrorState extends PatrState {}
