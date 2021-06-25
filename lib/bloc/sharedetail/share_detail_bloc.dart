import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qfvpn/model/api/api_repository.dart';

part 'share_detail_event.dart';
part 'share_detail_state.dart';

class ShareDetailBloc extends Bloc<ShareDetailEvent, ShareDetailState> {
  final ApiRepository apiRepository;

  ShareDetailBloc({required this.apiRepository}) : super(ShareDetailInitial());

  @override
  Stream<ShareDetailState> mapEventToState(
    ShareDetailEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
