import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/constraints/constants.dart';
import 'package:quran_app/screens/juz_screen.dart';
import 'package:quran_app/screens/splash_screen.dart';
import 'package:quran_app/screens/surah_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quran App',
      theme: ThemeData(

        primarySwatch: Constants.mySwatchColor,
        primaryColor: Constants.myPrimary,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashScreen(),
      routes: {
        JuzScreen.id:(context)=>JuzScreen(),
        SurahDetailScreen.id:(context)=>const SurahDetailScreen(),
      },
    );
  }
}


