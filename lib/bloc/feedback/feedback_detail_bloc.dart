import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/model/api/api_result.dart';
import 'package:qfvpn/model/api/bean/feedback/create_reply_req.dart';
import 'package:qfvpn/model/api/bean/feedback/detail_req.dart';
import 'package:qfvpn/model/api/bean/feedback/detail_resp.dart';
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
    if (event is FetchDetailEvent) {
      ApiResult result = await apiRepository
          .fetchFeedbackDetail(DetailReq(feedbackId: event.feedbackId));
      if (result is Success<DetailResp>) {
        yield DetailLoadedState(result.data!);
      } else if (result is Error) {
        Fimber.d('error: ${result.error.toString()}');
      }
    }
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
        feedbackId: 0,
        content: event.content,
        imageAttachmentIds: attachmentIdList));

    return result;
  }
}
