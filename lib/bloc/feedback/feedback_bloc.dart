import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:qfvpn/bloc/feedback/feedback_event.dart';
import 'package:qfvpn/bloc/feedback/feedback_state.dart';
import 'package:qfvpn/constants.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/model/api/api_result.dart';
import 'package:qfvpn/model/api/bean/feedback/feedback_list_resp.dart';
import 'package:qfvpn/model/api/bean/feedback/paging.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final ApiRepository apiRepository;

  FeedbackBloc({required this.apiRepository}) : super(FeedbackInitState());

  @override
  Stream<FeedbackState> mapEventToState(FeedbackEvent event) async* {
    if (event is FetchFeedbackEvent) {
      ApiResult result = await apiRepository
          .fetchFeedbackList(Paging(pageNo: event.pageNo, pageSize: PAGE_SIZE));
      if (result is Success<FeedbackListResp>) {
        Fimber.d('result: ${result.data?.totalCount ?? 0}');
        yield LoadedState(result.data!);
      } else if (result is Error) {
        Fimber.d('error: ${result.error.toString()}');
      }
    }
  }
}
