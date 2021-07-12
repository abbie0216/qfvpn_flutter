import 'package:equatable/equatable.dart';

abstract class AddFeedbackEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateEvent extends AddFeedbackEvent {
  final String content;
  final int categoryId;
  final List<String> filePathList;

  CreateEvent(this.content, this.categoryId, this.filePathList);

  @override
  List<Object> get props => [content, categoryId, filePathList];
}
