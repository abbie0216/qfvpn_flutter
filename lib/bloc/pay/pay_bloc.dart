import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qfvpn/model/api/api_repository.dart';

part 'pay_event.dart';
part 'pay_state.dart';

class PayBloc extends Bloc<PayEvent, PayState> {
  final ApiRepository apiRepository;

  PayBloc({required this.apiRepository}) : super(PayInitial());

  @override
  Stream<PayState> mapEventToState(
    PayEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
