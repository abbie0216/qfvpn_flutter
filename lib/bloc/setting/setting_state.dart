part of 'setting_bloc.dart';

@immutable
abstract class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object> get props => [];
}


class SettingInitState extends SettingState {
}