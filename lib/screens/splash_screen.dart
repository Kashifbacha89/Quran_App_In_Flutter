import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'on_bording_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool alreadyUsed=false;
  void getData()async{
    //get sharedPreferences
    final sp=await SharedPreferences.getInstance();
    alreadyUsed= sp.getBool('alreadyUsed')?? false;


  }


  @override
  void initState() {
    getData();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>alreadyUsed?const OnBoardingScreen():const MainScreen()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Stack(
        children: [
          Center(child: Text('QURAN APP',style: GoogleFonts.aboreto(
            textStyle: const TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),
          ),),),
          const Positioned(
              left: 0,
              bottom: 0,
              right: 0,

              child: Image(image: AssetImage('assets/images/islamic.png'),)),
        ],
      ),
    ));
  }
}
