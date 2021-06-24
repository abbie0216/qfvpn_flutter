import 'package:equatable/equatable.dart';

abstract class ShareEvent extends Equatable {
  const ShareEvent();

  @override
  List<Object> get props => [];
}

class ShareFetchEvent extends ShareEvent {}