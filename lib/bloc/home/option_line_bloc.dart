import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/model/api/api_result.dart';
import 'package:qfvpn/model/api/bean/node/node_list_result.dart';

part 'option_line_event.dart';

part 'option_line_state.dart';

class OptionLineBloc extends Bloc<OptionLineEvent, OptionLineState> {
  final ApiRepository apiRepository;

  OptionLineBloc({required this.apiRepository}) : super(InitState());

  @override
  Stream<OptionLineState> mapEventToState(
    OptionLineEvent event,
  ) async* {
    if (event is OptionLineFetchEvent) {
      ApiResult result = await apiRepository.fetchNodeList();
      if (result is Success) {
        yield LoadedState(result.data);
      } else if (result is Error) {
        Fimber.d('error: ${result.error.toString()}');
      }
    }
  }
}
