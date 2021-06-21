import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/model/api/api_repository.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiRepository apiRepository;

  HomeBloc({required this.apiRepository}) : super(HomeInitState());

  @override
  Stream<HomeState> mapEventToState(
      HomeEvent event,
      ) async* {
    // TODO: implement mapEventToState
  }

}