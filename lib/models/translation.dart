class SurahTranslationList{
  final List<SurahTranslation> tanslationList;
  SurahTranslationList({required this.tanslationList});
  factory SurahTranslationList.formJSON(Map<String,dynamic>map) {
    Iterable translation=map['result'];
    List<SurahTranslation> list= translation.map((e) => SurahTranslation.fromJSON(e)).toList();
    print(list.length);
    return SurahTranslationList(tanslationList: list);
  }
}
class SurahTranslation{
  String? sura;
  String? aya;
  String? arabic_text;
  String? translation;

  SurahTranslation({this.sura, this.aya, this.arabic_text, this.translation});
  factory SurahTranslation.fromJSON(Map<String,dynamic>json){
    return SurahTranslation(
      sura: json['sura'],
      aya: json['aya'],
      arabic_text: json['arabic_text'],
      translation: json['translation'],
    );
  }
}