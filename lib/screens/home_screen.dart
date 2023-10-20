import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:quran_app/models/aya_of_the_day.dart';
import 'package:quran_app/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void setData()async{
    final sp=await SharedPreferences.getInstance();
    sp.setBool('alreadyUsed ', true);
  }

  @override
  void initState() {
    setData();
    // TODO: implement initState
    super.initState();
  }


  ApiServices myAyahApis = ApiServices();

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    HijriCalendar.setLocal('ar');
    var _hijri = HijriCalendar.now();
    var day = DateTime.now();
    var format = DateFormat('EEE , d MMM yyyy');
    var formatted = format.format(day);

    return SafeArea(
        child: Scaffold(
            body: Column(
      children: [
        //for date
        Container(
          height: _size.height * .22,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/background_img.jpg'),
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  formatted,
                  style: const TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              RichText(
                  text: TextSpan(children: <InlineSpan>[
                WidgetSpan(
                    child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    _hijri.hDay.toString(),
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                )),
                WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      _hijri.longMonthName.toString(),
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      '${'${_hijri.hYear} AH'}',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ])),
            ],
          ),
        ),
        //for ayah of the day
        Expanded(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(top: 10, bottom: 20),
            child: Column(
              children: [
                FutureBuilder<AyaOfTheDay>(
                    future: myAyahApis.getAyaOfTheDay(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.none) {
                        return const Icon(Icons.sync_problem);
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else {
                        return Container(
                            margin: const EdgeInsetsDirectional.all(16),
                            padding: const EdgeInsetsDirectional.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 3,
                                  spreadRadius: 1,
                                  offset: Offset(0,1),

                                )
                              ]
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Quran Ayah Of The Day',
                                  style: GoogleFonts.aclonica(
                                    textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Divider(
                                  color: Colors.black,
                                  thickness: 0.5,
                                ),
                                Text(
                                  snapshot.data!.arabicText!,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.aclonica(
                                    textStyle:
                                        const TextStyle(color: Colors.black,fontSize: 18),

                                  ),
                                ),
                                Text(
                                  snapshot.data!.engTran!,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.acme(
                                    textStyle:
                                        const TextStyle(color: Colors.black54,fontSize: 18),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    RichText(
                                      text: TextSpan(
                                        children: <InlineSpan>[
                                          WidgetSpan(
                                              child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Ayah#  ${snapshot.data!.surahNumber!
                                                  .toString()}',
                                              style: GoogleFonts.acme(
                                                textStyle:
                                                const TextStyle(color: Colors.black54,fontSize: 16),
                                              ),
                                            ),
                                          )),
                                          WidgetSpan(
                                              child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Surah # ${snapshot.data!.surEngName!}',
                                              style: GoogleFonts.acme(
                                                textStyle:
                                                const TextStyle(color: Colors.black54,fontSize: 16),
                                              ),
                                            ),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ));
                      }
                    }),
              ],
            ),
          ),
        ))
      ],
    )));
  }
}
