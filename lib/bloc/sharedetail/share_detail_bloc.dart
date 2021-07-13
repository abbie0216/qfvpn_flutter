import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/model/api/api_result.dart';
import 'package:qfvpn/model/api/bean/invite/invite_list_resp.dart';
import 'package:qfvpn/model/api/bean/paging.dart';

import '../../constants.dart';

part 'share_detail_event.dart';
part 'share_detail_state.dart';

class ShareDetailBloc extends Bloc<ShareDetailEvent, ShareDetailState> {
  final ApiRepository apiRepository;

  ShareDetailBloc({required this.apiRepository}) : super(InitState());

  @override
  Stream<ShareDetailState> mapEventToState(
    ShareDetailEvent event,
  ) async* {
    if (event is FetchListEvent) {
      ApiResult result = await apiRepository
          .fetchInviteList(Paging(pageNo: event.pageNo, pageSize: PAGE_SIZE));
      if (result is Success) {
        yield LoadedState(result.data);
      } else if (result is Error) {
        Fimber.d('error: ${result.error.toString()}');
      }
    }
  }
}
