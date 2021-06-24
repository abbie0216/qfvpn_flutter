import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/model/api/api_repository.dart';

import 'share_event.dart';
import 'share_state.dart';

class ShareBloc extends Bloc<ShareEvent, ShareState> {
  final ApiRepository apiRepository;

  ShareBloc({required this.apiRepository}) : super(ShareInitState());

  @override
  Stream<ShareState> mapEventToState(
      ShareEvent event,
      ) async* {
    // TODO: implement mapEventToState
  }

}