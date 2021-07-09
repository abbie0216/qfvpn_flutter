import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/model/api/api_result.dart';
import 'package:qfvpn/model/api/bean/node/node_list_resp.dart';
import 'package:qfvpn/model/bean/option_btn_info.dart';
import 'package:qfvpn/model/pref.dart';

part 'option_btn_event.dart';
part 'option_btn_state.dart';

class OptionBtnBloc extends Bloc<OptionBtnEvent, OptionBtnState> {
  final ApiRepository apiRepository;
  final Pref _pref = Pref();

  OptionBtnBloc({required this.apiRepository}) : super(InitState());

  @override
  Stream<OptionBtnState> mapEventToState(
    OptionBtnEvent event,
  ) async* {
    if (event is OptionBtnFetchEvent) {
      var _optionMode = await _pref.getOptionMode();
      var _optionLine = await _pref.getOptionLine();
      Fimber.d('OptionBtn: $_optionMode, $_optionLine');
      _optionMode ??= 0;
      if (_optionLine == null) {
        var result = await apiRepository.fetchNodeList();
        if (result is Success<NodeListResp>) {
          _optionLine = result.data?.items?.first;
        } else if (result is Error<NodeListResp>) {
          Fimber.d('error: ${result.error.toString()}');
        }
      }
      yield LoadedState(OptionBtnInfo(_optionMode, _optionLine));
    }
  }
}
