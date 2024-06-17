abstract class UiState { }

class LoadingState implements UiState { }
class SuccessState implements UiState { }
class FailureState implements UiState {
  final String? message;
  FailureState({this.message});
}

abstract class UiEvent { }
class InitEvent implements UiEvent { }
class UpdateEvent implements UiEvent { }
class ErrorEvent implements UiEvent {
  final String? message;
  ErrorEvent({this.message});
}

