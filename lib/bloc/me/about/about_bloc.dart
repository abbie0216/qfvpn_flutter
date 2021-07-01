import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qfvpn/model/api/api_repository.dart';

part 'about_event.dart';
part 'about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  final ApiRepository apiRepository;
  AboutBloc({required this.apiRepository}) : super(AboutInitial());

  @override
  Stream<AboutState> mapEventToState(
    AboutEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
