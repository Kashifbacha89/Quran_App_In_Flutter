import 'package:flutter/material.dart';
import 'package:quran_app/models/juz_model.dart';


class JuzCustomTile extends StatelessWidget {
  final List<JuzAyahs> list;
  final int index;

  const JuzCustomTile({super.key, required this.list,required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(list[index].ayahNumber.toString()),
            Text(list[index].ayahsText,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w700),
              textAlign: TextAlign.end,),
            Text(list[index].surahName,textAlign: TextAlign.end,),
          ],
        ),
      ),
    );
  }
}

