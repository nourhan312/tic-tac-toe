abstract class GameState {}

class GameInitial extends GameState {}

class ChangePlayer extends GameState {}

class BoxAlreadyHaveData extends GameState {
  late String message; //
  BoxAlreadyHaveData({required this.message});
}

class FinishedWithWinner extends GameState {
  late String winner;
  FinishedWithWinner({required this.winner});
}

class FinishedWithoutWinner extends GameState {}

class OneOfThemWinTheGame extends GameState {}
