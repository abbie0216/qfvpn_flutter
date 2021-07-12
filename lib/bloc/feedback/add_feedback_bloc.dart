import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:qfvpn/model/api/api_repository.dart';
import 'package:qfvpn/model/api/api_result.dart';
import 'package:qfvpn/model/api/bean/feedback/create_feedback_req.dart';
import 'package:qfvpn/model/api/bean/feedback/upload_attachment_resp.dart';

import 'add_feedback_event.dart';
import 'add_feedback_state.dart';

class AddFeedbackBloc extends Bloc<AddFeedbackEvent, AddFeedbackState> {
  final ApiRepository apiRepository;

  AddFeedbackBloc({required this.apiRepository}) : super(InitState());

  @override
  Stream<AddFeedbackState> mapEventToState(AddFeedbackEvent event) async* {
    if (event is CreateEvent) {
      ApiResult result = await createFeedback(event);
      if (result is Success) {
        Fimber.d('Success');
        yield CreateSuccessState();
      } else if (result is Error) {
        Fimber.d('Error: ${result.error}');
        yield CreateErrorState(result.error);
      }
    }
  }

  Future<ApiResult<void>> createFeedback(CreateEvent event) async {
    var attachmentIdList = <int>[];
    var att = <Future<ApiResult<UploadAttachmentResp>>>[];
    event.filePathList
        .forEach((element) => att.add(apiRepository.uploadAttachment(element)));
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

    ApiResult result = await apiRepository.createFeedback(CreateFeedbackReq(
        content: event.content,
        categoryId: event.categoryId,
        imageAttachmentIds: attachmentIdList));

    return result;
  }
}
