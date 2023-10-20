import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/constraints/constants.dart';
import 'package:quran_app/models/my_surah_model.dart';
import 'package:quran_app/models/qari.dart';
import 'package:quran_app/screens/audio_screen.dart';
import 'package:quran_app/services/api_service.dart';

class AudioSurahScreen extends StatefulWidget {
  const AudioSurahScreen({Key? key, required this.qari}) : super(key: key);
  final Qari qari;

  @override
  State<AudioSurahScreen> createState() => _AudioSurahScreenState();
}

class _AudioSurahScreenState extends State<AudioSurahScreen> {
  ApiServices mySurahApi = ApiServices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Surah List',
            style: GoogleFonts.acme(
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: mySurahApi.getSurah(),
          builder: (context, AsyncSnapshot<List<Surah>> snapshot) {
            if (snapshot.hasData) {
              List<Surah>? surah = snapshot.data;
              return ListView.builder(
                  itemCount: surah!.length, itemBuilder: (context, index) {
                    return AudioTile(
                        surahName: snapshot.data![index].englishName,
                        totalAya: snapshot.data![index].numberOfAyahs,
                        number: snapshot.data![index].number,
                        ontap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=> AudioScreen(
                            qari:widget.qari,
                            index:index+1,
                            list:surah
                          )));
                        });
              });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

Widget AudioTile(
    {required String? surahName,
    required totalAya,
    required number,
    required VoidCallback ontap}) {
  return GestureDetector(
    onTap: ontap,
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                blurRadius: 8,
                spreadRadius: 0,
                color: Colors.black12,
                offset: Offset(0, 8),
              ),
            ]
          ),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: 30,
                  width: 40,
                padding:const  EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,

                ),
                child: Text((number).toString(),style: const TextStyle(
                  color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10
                ),),
              ),
              const SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(surahName!,
                  textAlign: TextAlign.end,
                  style: GoogleFonts.aBeeZee(
                    textStyle: const TextStyle(
                      fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold
                    ),
                  ),
                  ),
                  const SizedBox(height: 4,),
                  Text('Total Aya : $totalAya',style: const TextStyle(fontSize: 16,color: Colors.black54),)
                ],
              ),
              const Spacer(),
              const Icon(Icons.play_circle_fill,color: Constants.myPrimary,size: 25,)
            ],
          ),
        ),
      ),
    ),
  );



}
