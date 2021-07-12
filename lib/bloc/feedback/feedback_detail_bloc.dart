import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/model/api/api_result.dart';
import 'package:qfvpn/model/api/bean/feedback/create_reply_req.dart';
import 'package:qfvpn/model/api/bean/feedback/detail_req.dart';
import 'package:qfvpn/model/api/bean/feedback/detail_resp.dart';
import 'package:qfvpn/model/api/bean/feedback/take_survey_req.dart';
import 'package:qfvpn/model/api/bean/feedback/upload_attachment_resp.dart';

import 'feedback_detail_event.dart';
import 'feedback_detail_state.dart';

class FeedbackDetailBloc
    extends Bloc<FeedbackDetailEvent, FeedbackDetailState> {
  final ApiRepository apiRepository;

  FeedbackDetailBloc({required this.apiRepository}) : super(InitState());

  @override
  Stream<FeedbackDetailState> mapEventToState(
      FeedbackDetailEvent event) async* {
    yield LoadingState();
    if (event is FetchDetailEvent) {
      ApiResult result = await apiRepository
          .fetchFeedbackDetail(DetailReq(feedbackId: event.feedbackId));
      if (result is Success<DetailResp>) {
        yield DetailLoadedState(result.data!);
      } else if (result is Error) {
        Fimber.d('error: ${result.error.toString()}');
        yield DetailErrorState(result.error);
      }
    } else if (event is CreateReplyEvent) {
      ApiResult result = await createReply(event);
      if (result is Success) {
        yield CreateReplySuccessState();
      } else if (result is Error) {
        yield CreateReplyErrorState(result.error.toString());
      }
    } else if (event is TakeSurveyEvent) {
      ApiResult result = await apiRepository.takeSurvey(TakeSurveyReq(
          feedbackId: event.feedbackId, voteNumber: event.voteNumber));
      if (result is Success) {
        yield TakeSurveySuccessState();
      } else if (result is Error) {
        yield TakeSurveyErrorState(result.error);
      }
    }
    yield LoadedState();
  }

  Future<ApiResult<void>> createReply(CreateReplyEvent event) async {
    var attachmentIdList = <int>[];
    var att = <Future<ApiResult<UploadAttachmentResp>>>[];
    event.filePathList.forEach((element) =>
        att.add(apiRepository.uploadAttachment(element, isReply: true)));
    await Future.wait(att).then((value) => {
          value.forEach((result) {
            if (result is Success<UploadAttachmentResp>) {
              attachmentIdList.add(result.data!.attachmentId);
            } else if (result is Error) {
              Fimber.d('uploadAttachment Error: $result}');
            }
            return null;
          })
        });

    ApiResult result = await apiRepository.createReply(CreateReplyReq(
        feedbackId: event.feedbackId,
        content: event.content,
        imageAttachmentIds: attachmentIdList));

    return result;
  }
}
