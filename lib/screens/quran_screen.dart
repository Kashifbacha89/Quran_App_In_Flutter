import 'package:flutter/material.dart';
import 'package:quran_app/constraints/constants.dart';
import 'package:quran_app/models/my_sajda_model.dart';
import 'package:quran_app/models/my_surah_model.dart';
import 'package:quran_app/screens/juz_screen.dart';
import 'package:quran_app/screens/surah_detail_screen.dart';
import 'package:quran_app/services/api_service.dart';
import 'package:quran_app/widgets/sajda_custom_tile.dart';
import 'package:quran_app/widgets/surah_custom_list.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  ApiServices mySurahListApis = ApiServices();
  ApiServices mySajdaListApis = ApiServices();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                title: const Text('QURAN'),
                centerTitle: true,
                bottom: const TabBar(
                  tabs: [
                    Text(
                      'Surah',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                    Text(
                      'Sajda',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                    Text(
                      'Juz',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  //For Surah*******************************
                  FutureBuilder(
                    future: mySurahListApis.getSurah(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Surah>> snapshot) {
                      if (snapshot.hasData) {
                        List<Surah>? surah = snapshot.data;
                        return ListView.builder(
                          itemCount: surah!.length,
                          itemBuilder: (context, index) => SurahCustomListTile(
                              surah: surah[index],
                              context: context,
                              ontap: () {
                                setState(() {
                                  Constants.surahIndex=(index+1);
                                });
                                Navigator.pushNamed(context, SurahDetailScreen.id);
                              }),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),

                  //For Sajda
                  FutureBuilder(
                      future: mySajdaListApis.getSajdasData(),
                      builder: (context, AsyncSnapshot<MySajdaList> snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Something went wring'),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.builder(
                            itemCount: snapshot.data!.sajdaAyahs.length,
                            itemBuilder: (context, index) {
                              return SajdaCustomTile(
                                  snapshot.data!.sajdaAyahs[index], context);
                            });
                      }),
                  //for Juz ****************************
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          itemCount: 30,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  Constants.juzIndex = (index + 1);
                                });
                                Navigator.pushNamed(context, JuzScreen.id);
                              },
                              child: Card(
                                elevation: 4,
                                color: Colors.blueGrey,
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                ],
              ))),
    );
  }
}
