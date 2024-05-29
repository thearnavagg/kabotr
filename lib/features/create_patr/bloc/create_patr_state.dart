part of 'create_patr_bloc.dart';

@immutable
sealed class CreatePatrState {}

final class CreatePatrInitial extends CreatePatrState {}

abstract class CreatePatrActionState extends CreatePatrState {}

class CreatePatrLoadingState extends CreatePatrActionState {}

class CreatePatrSuccessState extends CreatePatrActionState {}

class CreatePatrErrorState extends CreatePatrActionState {}
