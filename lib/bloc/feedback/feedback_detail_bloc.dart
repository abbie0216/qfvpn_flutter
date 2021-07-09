import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/model/api/api_result.dart';
import 'package:qfvpn/model/api/bean/feedback/detail_req.dart';
import 'package:qfvpn/model/api/bean/feedback/detail_resp.dart';

import 'feedback_detail_event.dart';
import 'feedback_detail_state.dart';

class FeedbackDetailBloc extends Bloc<FeedbackDetailEvent, FeedbackDetailState> {
  final ApiRepository apiRepository;

  FeedbackDetailBloc({required this.apiRepository}) : super(InitState());

  @override
  Stream<FeedbackDetailState> mapEventToState(FeedbackDetailEvent event) async* {
    if (event is FetchDetailEvent) {
      ApiResult result = await apiRepository
          .fetchFeedbackDetail(DetailReq(feedbackId: event.feedbackId));
      if (result is Success<DetailResp>) {
        yield LoadedState(result.data!);
      } else if (result is Error) {
        Fimber.d('error: ${result.error.toString()}');
      }
    }
  }
}
