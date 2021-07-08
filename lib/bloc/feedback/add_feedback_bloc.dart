import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/model/api/api_repository.dart';

import 'add_feedback_event.dart';
import 'add_feedback_state.dart';

class AddFeedbackBloc extends Bloc<AddFeedbackEvent, AddFeedbackState> {
  final ApiRepository apiRepository;

  AddFeedbackBloc({required this.apiRepository}) : super(InitState());

  @override
  Stream<AddFeedbackState> mapEventToState(AddFeedbackEvent event) async* {
  }
}