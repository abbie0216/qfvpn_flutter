import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/feedback/feedback_event.dart';
import 'package:qfvpn/bloc/feedback/feedback_state.dart';
import 'package:qfvpn/model/api/api_repository.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final ApiRepository apiRepository;

  FeedbackBloc({required this.apiRepository}) : super(FeedbackInitState());

  @override
  Stream<FeedbackState> mapEventToState(
      FeedbackEvent event,
      ) async* {
    // TODO: implement mapEventToState
  }

}