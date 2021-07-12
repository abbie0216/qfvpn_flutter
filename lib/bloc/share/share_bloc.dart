import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:qfvpn/model/api/api_result.dart';
import 'package:qfvpn/model/api/bean/invite/invite_info_resp.dart';

part 'share_event.dart';
part 'share_state.dart';

class ShareBloc extends Bloc<ShareEvent, ShareState> {
  final ApiRepository apiRepository;

  ShareBloc({required this.apiRepository}) : super(InitState());

  @override
  Stream<ShareState> mapEventToState(
      ShareEvent event,
      ) async* {
    if(event is ShareInfoFetchEvent){
      ApiResult result = await apiRepository.fetchInviteInfo();
      if (result is Success) {
        yield LoadedState(result.data);
      } else if (result is Error) {
        Fimber.d('error: ${result.error.toString()}');
      }
    }
  }

}