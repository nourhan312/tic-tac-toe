import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac/featurs/cubit/game_cubit.dart';
import 'package:tic_tac/featurs/cubit/game_state.dart';

import '../../core/compontes/compontes.dart';
import '../../core/utils/AppColors.dart';
import '../../core/utils/app_strings.dart';

class Game extends StatefulWidget {
  final String playerX;
  final String playerO;

  Game({required this.playerX, required this.playerO});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  late SharedPreferences prefs;
  late Future<void> prefsFuture;

  void initState() {
    super.initState();
    initSharedPreferences();
    prefsFuture = initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  //  update player points when the game ends
  Future<void> updatePlayerPoints(String winner) async {
    if (winner == 'X') {
      final int playerXPoints = prefs.getInt('playerXPoints') ?? 0;
      await prefs.setInt('playerXPoints', playerXPoints + 1);
    } else if (winner == 'O') {
      final int playerOPoints = prefs.getInt('playerOPoints') ?? 0;
      await prefs.setInt('playerOPoints', playerOPoints + 1);
    }
  }

  Future<void> restPlayerPoints() async {
// Remove data for the 'counter' key.
    await prefs.remove('playerXPoints');
    await prefs.remove('playerOPoints');
  }

  @override
  Widget build(BuildContext context) {
    final cubit = GameCubit.getInstance(context);

    return FutureBuilder<void>(
        future: prefsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return BlocConsumer<GameCubit, GameState>(
                listener: (context, state) {
              if (state is FinishedWithWinner) {
                awesomeDialog(
                    context: context,
                    message:
                        "The Winner is ${state.winner == cubit.Player1 ? widget.playerX : widget.playerO}",
                    dialogType: DialogType.success,
                    messageColor: Colors.green,
                    dialogTitle: "Congratulations",
                    gameEnd: true);
                updatePlayerPoints(state.winner);

                print(state);
              } else if (state is FinishedWithoutWinner) {
                awesomeDialog(
                    context: context,
                    message: "Game finished without Winner !",
                    dialogType: DialogType.error,
                    messageColor: Colors.red,
                    dialogTitle: "Game Over",
                    gameEnd: true);
                print(state);
              } else if (state is BoxAlreadyHaveData) {
                awesomeDialog(
                    context: context,
                    message: "This Box already has Data !",
                    dialogType: DialogType.warning,
                    messageColor: Colors.red,
                    dialogTitle: "Warning",
                    gameEnd: false);
                print(state);
              }
            }, builder: (context, state) {
              return Scaffold(
                  body: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            // width: 120,
                            height: 100,
                            alignment: Alignment.center,
                            curve: Curves.easeInOutBack,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: AppColors.pink),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  '${widget.playerX} ',
                                  style: GoogleFonts.poppins(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 30,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  ' ${prefs.getInt('playerXPoints') ?? 0}',
                                  style: GoogleFonts.poppins(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 30,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          flex: 2,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            // width: 120,
                            height: 100,
                            alignment: Alignment.center,
                            curve: Curves.easeInOutBack,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: AppColors.babyblue,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${widget.playerO}  ',
                                  style: GoogleFonts.poppins(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 30,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '${prefs.getInt('playerOPoints') ?? 0}',
                                  style: GoogleFonts.poppins(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 30,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 4,
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 2),
                            //  width: 200,
                            height: 70,
                            alignment: Alignment.center,
                            curve: Curves.easeIn,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.subTitleColor.withOpacity(0.10),
                            ),
                            child: Text(
                              AppStrings.curr,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          flex: 2,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            // width: 120,
                            height: 70,
                            alignment: Alignment.center,
                            curve: Curves.easeIn,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: cubit.CurrPlayer == cubit.Player1
                                  ? AppColors.pink
                                  : cubit.CurrPlayer == cubit.Player2
                                      ? AppColors.babyblue
                                      : Colors.grey.withOpacity(0.2),
                            ),
                            child: Text(
                              cubit.CurrPlayer == cubit.Player1
                                  ? widget.playerX // Display Player X's name
                                  : cubit.CurrPlayer == cubit.Player2
                                      ? widget
                                          .playerO // Display Player O's name
                                      : '',
                              style: GoogleFonts.poppins(
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        padding: const EdgeInsets.all(8),
                        itemCount: 9,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              cubit.boxClicked(index: index);
                            },
                            child: AnimatedContainer(
                                alignment: Alignment.center,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  //color: AppColors.subTitleColor.withOpacity(0.10),
                                  color: cubit.boxesData[index] == cubit.Player1
                                      ? AppColors.pink
                                      : cubit.boxesData[index] == cubit.Player2
                                          ? AppColors.babyblue
                                          : Colors.grey.withOpacity(0.2),
                                ),
                                child: AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn,
                                  style: GoogleFonts.poppins(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700),
                                  child: Text(cubit.boxesData[index]),
                                )),
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: AppColors.babyblue,
                          // Change the text color
                          elevation: 5,
                          // Change the shadow elevation
                          padding: const EdgeInsets.all(16.0),
                          // Change the padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Change the border radius
                            side: const BorderSide(
                                color: AppColors.babyblue,
                                width:
                                    2.0), // Change the border color and width
                          ),
                        ),
                        onPressed: () {
                          restPlayerPoints();
                          cubit.gameInitial();
                        },
                        child: Text(
                          AppStrings.rest,
                          style: GoogleFonts.poppins(
                            color: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        )),
                  ],
                ),
              ));
            });
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
