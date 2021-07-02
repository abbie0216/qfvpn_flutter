part of 'about_bloc.dart';

abstract class AboutEvent extends Equatable {
  const AboutEvent();
  @override
  List<Object?> get props => [];
}

class AppVersionEvent extends AboutEvent {}