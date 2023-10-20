import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/models/my_surah_model.dart';

Widget SurahCustomListTile(
{
  required Surah surah,
required BuildContext context,
required VoidCallback ontap
}
){
  return GestureDetector(
    onTap: ontap,
    child: Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3.0,

          ),
        ]
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: 30,
                width: 40,
                padding:const  EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: Text((surah.number).toString(),style: const TextStyle(
                  color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold
                ),),

              ),
             const  SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(surah!.englishName!,style: GoogleFonts.aBeeZee(
                    textStyle: const TextStyle(fontSize: 18)
                  ),),
                  Text(surah.englishNameTranslation!,style: GoogleFonts.acme(
                      textStyle: const TextStyle(fontSize: 15,)
                  ),),
                  Text(' Total Ayahs:${surah.numberOfAyahs!.toString()}',style: GoogleFonts.abel(
                      textStyle: const TextStyle(fontSize: 15,)
                  ),)

                ],
              ),
              const Spacer(),
              Text(surah.name!,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
            ],
          )
        ],
      ),
    ),
  );
}
