abstract class MyAppState {}

class MyAppInitial extends MyAppState {}

//For Products Grid
class LoadingGridState extends MyAppState {}

class DoneGridState extends MyAppState {}

class ErrorGridState extends MyAppState {}

//For Counter Page

class CalculatedSum extends MyAppState {}

//For Login Page

class LoadingLoginState extends MyAppState {}

class DoneLoginState extends MyAppState {}

class ErrorLoginState extends MyAppState {
  final String error;

  ErrorLoginState(this.error);
}
//For Create Account Page

class LoadingCreateState extends MyAppState {}

class DoneCreateState extends MyAppState {}

class ErrorCreateState extends MyAppState {
  final String error;

  ErrorCreateState(this.error);
}
