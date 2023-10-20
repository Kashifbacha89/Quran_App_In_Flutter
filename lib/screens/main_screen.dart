import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/constraints/constants.dart';
import 'package:quran_app/screens/prayer_timing_screen.dart';
import 'package:quran_app/screens/qariList_screen.dart';
import 'package:quran_app/screens/home_screen.dart';
import 'package:quran_app/screens/quran_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectIndex=0;
  final List<Widget> _widgetList=  [const HomeScreen(),const QuranScreen(),const QariListScreen(),const PrayerTimingScreen()];
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(

        body: _widgetList[selectIndex],
          bottomNavigationBar: ConvexAppBar(
            items:   [
               TabItem(icon: Image.asset('assets/images/home.png',color: Colors.white,), title: 'Home'),
              TabItem(icon: Image.asset('assets/images/holyQuran.png',color: Colors.white), title: 'Quran'),
               TabItem(icon: Image.asset('assets/images/audio.png',color: Colors.white), title: 'Audio'),
              TabItem(icon: Image.asset('assets/images/mosque.png',color: Colors.white), title: 'Prayer'),

            ],
            initialActiveIndex: 0,
            onTap: updateIndex,
            backgroundColor: Constants.myPrimary,
            activeColor: Constants.myPrimary,
          )
      ),
    );
  }
  void updateIndex(index){
    setState(() {
      selectIndex=index;
    });
  }
}
