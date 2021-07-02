part of 'me_bloc.dart';

abstract class MeState extends Equatable {
  const MeState();
  @override
  List<Object> get props => [];
}

class MeInitState extends MeState {}

class AppVersionState extends MeState{
  final String appVersion;
  const AppVersionState({required this.appVersion});
}