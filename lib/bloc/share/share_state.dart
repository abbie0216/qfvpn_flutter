import 'package:equatable/equatable.dart';

abstract class ShareState extends Equatable {
  const ShareState();

  @override
  List<Object> get props => [];
}

class ShareInitState extends ShareState {}

class ShareLoadedState extends ShareState {}