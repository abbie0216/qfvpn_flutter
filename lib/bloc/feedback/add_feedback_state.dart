import 'package:equatable/equatable.dart';
import 'package:qfvpn/model/api/bean/feedback/category_list_resp.dart';

abstract class AddFeedbackState extends Equatable {
  const AddFeedbackState();

  @override
  List<Object> get props => [];
}

class InitState extends AddFeedbackState {}

class LoadingState extends AddFeedbackState {}

class LoadedState extends AddFeedbackState {}

class CreateSuccessState extends AddFeedbackState {}

class CreateErrorState extends AddFeedbackState {
  final String error;

  CreateErrorState(this.error) : super();

  @override
  List<Object> get props => [error];
}

class CategoryListLoadedState extends AddFeedbackState {
  final CategoryListResp result;

  CategoryListLoadedState(this.result) : super();

  @override
  List<Object> get props => [result];
}

class CategoryListErrorState extends AddFeedbackState {
  final String error;

  CategoryListErrorState(this.error) : super();

  @override
  List<Object> get props => [error];
}
