abstract class UiState { }

class LoadingState implements UiState { }
class SuccessState implements UiState { }
class FailureState implements UiState { }

abstract class UiEvent { }
class InitEvent implements UiEvent { }
class UpdateEvent implements UiEvent { }

