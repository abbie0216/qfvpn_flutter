import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/model/api/api_result.dart';
import 'package:qfvpn/model/api/bean/node/node_list_result.dart';

part 'line_selector_event.dart';
part 'line_selector_state.dart';

class LineSelectorBloc extends Bloc<LineSelectorEvent, LineSelectorState> {
  final ApiRepository apiRepository;

  LineSelectorBloc({required this.apiRepository}) : super(InitState());

  @override
  Stream<LineSelectorState> mapEventToState(
    LineSelectorEvent event,
  ) async* {
    if (event is LineSelectorFetchEvent) {
      ApiResult result = await apiRepository.fetchNodeList();
      if (result is Success) {
        yield LoadedState(result.data);
      } else if (result is Error) {
        Fimber.d('error: ${result.error.toString()}');
      }
    }
  }
}
