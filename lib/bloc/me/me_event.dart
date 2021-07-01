part of 'me_bloc.dart';


abstract class MeEvent extends Equatable {
  const MeEvent();
  @override
  List<Object?> get props => [];
}

class AppVersionEvent extends MeEvent {}
