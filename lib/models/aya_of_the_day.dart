class AyaOfTheDay {
  final String? arabicText;
  final String? engTran;
  final String? surEngName;
  final int? surahNumber;

  AyaOfTheDay({this.arabicText, this.engTran, this.surEngName, this.surahNumber});
  factory AyaOfTheDay.fromJSON(Map<String,dynamic> json){
    return AyaOfTheDay(
      arabicText: json['data'][0]['text'],
      engTran: json['data'][2]['text'],
      surEngName: json ['data'][2]['surah']['englishName'],
      surahNumber: json['data'][2]['numberInSurah']
    );
  }
}
