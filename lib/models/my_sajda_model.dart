class MySajdaList{
  final List<SajdaAyat> sajdaAyahs;
  MySajdaList({required this.sajdaAyahs});


  factory MySajdaList.fromJson(Map<String,dynamic> json){
    Iterable allSajdas=json['data']['ayahs'];

    List<SajdaAyat> sajdas = allSajdas.map((e) => SajdaAyat.fromJSON(e)).toList();
    return MySajdaList(sajdaAyahs: sajdas);

  }
}
class SajdaAyat{
  final int number;
  final String text;
  final String surahName;
  final String surahEnglishName;
  final String englishNameTranslation;
  final String revelationType;
  final int juzNumber;
  final int manzilNumber;
  final int rukuNumber;
  final int sajdaNumber;

  SajdaAyat({
      required this.number,
      required this.text,
      required this.surahName,
      required this.surahEnglishName,
      required this.englishNameTranslation,
      required this.revelationType,
      required this.juzNumber,
      required this.manzilNumber,
      required this.rukuNumber,
      required this.sajdaNumber});
  factory SajdaAyat.fromJSON(Map<String,dynamic>json){
    return SajdaAyat(
        number: json['number'],
        text: json['text'],
        surahName: json['surah']['name'],
        surahEnglishName: json['surah']['englishName'],
        englishNameTranslation: json['surah']['englishNameTranslation'],
        juzNumber: json['juz'],
        manzilNumber: json['manzil'],
        rukuNumber: json['ruku'],
        revelationType: json['surah']['revelationType'],
        sajdaNumber: json['sajda']['id']
    );
  }
}