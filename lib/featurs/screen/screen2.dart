import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tic_tac/core/utils/app_images.dart';
import 'package:tic_tac/core/utils/app_strings.dart';
import 'package:tic_tac/featurs/screen/game.dart';

import '../../core/utils/AppColors.dart';

class PlayerScreen extends StatefulWidget {
  PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final playerx_controller = TextEditingController();
  final playery_controller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool valid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(29.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 350,
                  width: 430,
                  child: Lottie.asset(AppImages.imgPath2),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    AppStrings.play1_label,
                    style: GoogleFonts.poppins(
                      color: AppColors.purpule,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppStrings.valid;
                    }
                    return null;
                  },
                  controller: playerx_controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    hintText: AppStrings.x,
                    errorText: valid ? 'Value Can\'t Be Empty' : null,
                    errorStyle: GoogleFonts.poppins(
                      //  color: AppColors.txt,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    hintStyle: GoogleFonts.poppins(
                      color: AppColors.Text,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.pink,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    AppStrings.play2_label,
                    style: GoogleFonts.poppins(
                      color: AppColors.purpule,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
                  controller: playery_controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    hintText: "PLayer O",
                    errorText: valid ? 'Value Can\'t Be Empty' : null,
                    hintStyle: GoogleFonts.poppins(
                      color: AppColors.Text,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                    errorStyle: GoogleFonts.poppins(
                      //  color: AppColors.txt,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.pink,
                        width: 1.8,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.pink, // Change the text color
                      elevation: 5, // Change the shadow elevation
                      padding: EdgeInsets.all(16.0), // Change the padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Change the border radius
                        side: const BorderSide(
                            color: AppColors.pink,
                            width: 2.0), // Change the border color and width
                      ),
                    ),
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Game(
                                playerX: playerx_controller.text,
                                playerO: playery_controller.text);
                          },
                        ));
                      }
                    },
                    child: Text(
                      AppStrings.start,
                      style: GoogleFonts.poppins(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
