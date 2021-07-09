import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:qfvpn/bloc/feedback/feedback_list_event.dart';
import 'package:qfvpn/bloc/feedback/feedback_list_state.dart';
import 'package:qfvpn/constants.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/model/api/api_result.dart';
import 'package:qfvpn/model/api/bean/feedback/feedback_list_resp.dart';
import 'package:qfvpn/model/api/bean/feedback/paging.dart';

class FeedbackListBloc extends Bloc<FeedbackListEvent, FeedbackListState> {
  final ApiRepository apiRepository;

  FeedbackListBloc({required this.apiRepository}) : super(InitState());

  @override
  Stream<FeedbackListState> mapEventToState(FeedbackListEvent event) async* {
    if (event is FetchListEvent) {
      ApiResult result = await apiRepository
          .fetchFeedbackList(Paging(pageNo: event.pageNo, pageSize: PAGE_SIZE));
      if (result is Success<FeedbackListResp>) {
        yield LoadedState(result.data!);
      } else if (result is Error) {
        Fimber.d('error: ${result.error.toString()}');
      }
    }
  }
}
