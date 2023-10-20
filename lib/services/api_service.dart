import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';
import 'package:quran_app/models/aya_of_the_day.dart';
import 'package:http/http.dart' as http;
import 'package:quran_app/models/juz_model.dart';
import 'package:quran_app/models/my_sajda_model.dart';
import 'package:quran_app/models/my_surah_model.dart';
import 'package:quran_app/models/qari.dart';
import 'package:quran_app/models/translation.dart';

class ApiServices {
  final endPointUrl = "http://api.alquran.cloud/v1/surah";
  List<Surah> surahList = [];

  Future<AyaOfTheDay> getAyaOfTheDay() async {
    //for random aya we need to generate random number
    //(1,6237) Total Ayah select from 1 to 6236
    String url =
        'http://api.alquran.cloud/v1/ayah/${random(1, 6237)}/editions/quran-uthmani,en.asad,en.pickthall';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return AyaOfTheDay.fromJSON(json.decode(response.body));
    } else {
      print('Failed to Load');
      throw Exception('Failed to Load Post');
    }
  }
  random(min, max) {
    var rn = Random();
    return min + rn.nextInt(max - min);
  }

//Fetch api's of Surah
Future<List<Surah>> getSurah()async{
    Response res=await http.get(Uri.parse(endPointUrl));
    if(res.statusCode==200){
      Map<String,dynamic> json=jsonDecode(res.body);
      json['data'].forEach((element){
        if(surahList.length<114){
          surahList.add(Surah.fromJson(element));
        }
      });
      print('ol${surahList.length}');
      return surahList;
    }else{
      throw("can't get the Surah");
    }
}
//Fetch Sajda Apis
  Future<MySajdaList> getSajdasData() async{

    String url="http://api.alquran.cloud/v1/sajda/en.asad";
    final response= await http.get(Uri.parse(url));
    if(response.statusCode==200){
      return MySajdaList.fromJson(json.decode(response.body));
    }else{
      print('Failed to Load');
      throw Exception('Failed to load Post');
    }

}



//Fetch apis of Juz
  Future<JuzModel> getJuz(int index) async {
    String url = "http://api.alquran.cloud/v1/juz/$index/quran-uthmani";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return JuzModel.fromJSON(json.decode(response.body));
    } else {
      print("Failed to load");
      throw Exception("Failed  to Load Post");
    }
  }


  //Fetch Apis of Surah Translation
Future<SurahTranslationList> getTranslation(int index,int translationIndex) async{
    String language='';
    if(translationIndex==0){
      language="urdu_junagarhi";
    }else if(translationIndex==1){
      language="hindi_omari";
    }else if(translationIndex==2){
      language ="english_saheeh";
    }



    final url="https://quranenc.com/api/v1/translation/sura/$language/$index";
    var response=await http.get(Uri.parse(url));
    return  SurahTranslationList.formJSON(json.decode(response.body));


}


//Fetch Apis of Qari
  List<Qari> qarilist = [];

  Future<List<Qari>> getQariList() async {

    final url = "https://quranicaudio.com/api/qaris";
    final res = await http.get(Uri.parse(url));

    jsonDecode(res.body).forEach((element){
      if(qarilist.length<20) // 20 is not mandatory , you can change it upto 157
        qarilist.add(Qari.fromJson(element));
    });
    qarilist.sort((a,b)=>a.name!.compareTo(b.name!)); // sort according to A B C
    return qarilist;
  }




}



