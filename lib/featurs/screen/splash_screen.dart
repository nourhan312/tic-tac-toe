import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tic_tac/core/utils/AppColors.dart';
import 'package:tic_tac/core/utils/app_images.dart';
import 'package:tic_tac/core/utils/app_strings.dart';
import 'package:tic_tac/featurs/screen/screen2.dart';

class splashScreen extends StatefulWidget {
  splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
        const Duration(seconds: 6),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => PlayerScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(AppImages.imgPath),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.tic,
                  // color: Color(0xff2B3f53),
                  style: GoogleFonts.poppins(
                    color: AppColors.txt,
                    fontSize: 45,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  AppStrings.tac,
                  style: GoogleFonts.poppins(
                    color: AppColors.red,
                    fontWeight: FontWeight.w700,
                    fontSize: 40,
                  ),
                ),
                Text(
                  AppStrings.toe,
                  style: GoogleFonts.poppins(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 41,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
