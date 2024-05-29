part of 'patr_bloc.dart';

@immutable
sealed class PatrEvent {}

class PatrInitialFetchEvent extends PatrEvent {}
