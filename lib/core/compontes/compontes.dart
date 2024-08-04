import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../../featurs/cubit/game_cubit.dart';

AwesomeDialog awesomeDialog(
    {required BuildContext context,
    required String message,
    required DialogType dialogType,
    required Color messageColor,
    required String dialogTitle,
    required bool gameEnd}) {
  return AwesomeDialog(
    context: context,
    dialogType: dialogType,
    animType: AnimType.bottomSlide,
    title: dialogTitle,
    titleTextStyle: TextStyle(
        color: messageColor, fontWeight: FontWeight.bold, fontSize: 19),
    desc: message,
    descTextStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 17,
        color: Colors.black.withOpacity(0.5)),
    btnCancelOnPress: () {
      if (gameEnd == true) {
        GameCubit.getInstance(context).gameInitial();
      }
    },
    btnOkOnPress: () {
      if (gameEnd == true) {
        GameCubit.getInstance(context).gameInitial();
      }
    },
  )..show();
}
