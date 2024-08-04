import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitial());

  late String CurrPlayer;
  late String Winner;
  String Player1 = 'X';
  String Player2 = 'O';
  int filledBoxesNumber = 0;
  List<String> boxesData = List.filled(9, "");

  List<List<int>> winningPlaces = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  void gameInitial() {
    Winner = "";
    boxesData = List.filled(9, "");
    CurrPlayer = Player1;
    filledBoxesNumber = 0;
    emit(GameInitial());
  }

  // get Instance from This Cubit
  static GameCubit getInstance(BuildContext context) {
    return BlocProvider.of<GameCubit>(context);
  }

  Future<void> boxClicked({required int index}) async {
    // if any box empty

    if (boxesData[index].isEmpty && filledBoxesNumber <= 8) {
      boxesData[index] = CurrPlayer;
      filledBoxesNumber++;
      CurrPlayer = (CurrPlayer == Player1) ? Player2 : Player1;
      emit(ChangePlayer());
      // check if the game has ended
      checkTheEndOfTheGame();
    } else {
      emit(BoxAlreadyHaveData(message: "This Box already has data!"));
    }
  }

  Future<void> checkTheEndOfTheGame() async {
    // draw state
    for (var iteam in winningPlaces) {
      if (boxesData[iteam[0]] == boxesData[iteam[1]] &&
          boxesData[iteam[1]] == boxesData[iteam[2]] &&
          boxesData[iteam[1]].isNotEmpty) {
        Winner = boxesData[iteam[0]];
        emit(FinishedWithWinner(winner: Winner));
        return;
      }
    }
    if (filledBoxesNumber == 9) {
      emit(FinishedWithoutWinner());
    }
  }
}
