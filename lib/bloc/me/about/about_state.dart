part of 'about_bloc.dart';

abstract class AboutState extends Equatable {
  const AboutState();
  @override
  List<Object> get props => [];
}

class AboutInitial extends AboutState {
  @override
  List<Object> get props => [];
}

class AppVersionState extends AboutState{
  final String appVersion;
  const AppVersionState({required this.appVersion});
}