part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
   LoginState({
     required this.isEmailValid,
     required this.isPasswordValid,
     required this.showPassword
  });

  final bool isEmailValid;
  final bool isPasswordValid;
  final bool showPassword;

  bool get isFormValid => isEmailValid && isPasswordValid;

  @override
  List<Object> get props => [isEmailValid, isPasswordValid, showPassword];

  LoginState copyWith({
     bool? isEmailValid,
     bool? isPasswordValid,
     bool? showPassword
  }) {
    return LoginState(
      isEmailValid: isEmailValid?? this.isEmailValid ,
      isPasswordValid: isPasswordValid?? this.isPasswordValid ,
      showPassword: showPassword?? this.showPassword
    );
  }
}

// class LoginInitStat extends LoginState {}
