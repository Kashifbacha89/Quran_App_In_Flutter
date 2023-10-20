import 'package:flutter/material.dart';
import 'package:quran_app/constraints/constants.dart';
import 'package:quran_app/models/translation.dart';
import 'package:quran_app/services/api_service.dart';
import 'package:quran_app/widgets/custom_translation_tile.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
enum Translation {urdu,hindi,english}
class SurahDetailScreen extends StatefulWidget {
  static const String id='SurahDetailScreen';
  const SurahDetailScreen({Key? key}) : super(key: key);

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  ApiServices surahTransApis=ApiServices();
 // SolidController _controller=SolidController();
  Translation? _translation=Translation.urdu;
  @override
  Widget build(BuildContext context) {
    print(_translation!.index);
    return Scaffold(
      body: FutureBuilder(
        future: surahTransApis.getTranslation(Constants.surahIndex!,_translation!.index),
        builder: (context,AsyncSnapshot<SurahTranslationList> snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);

          }
          else if(snapshot.hasData){
            return Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ListView.builder(
                  itemCount: snapshot.data!.tanslationList.length,
                  itemBuilder: (context,index){
                return TranslationCustomTile(
                    index: index,
                    surahTranslation: snapshot.data!.tanslationList[index]);

              }),
            );
          }else{
            return const Center(child: Text('Data Not Found!'),);
          }

        },
      ),

      bottomSheet: SolidBottomSheet(
        headerBar: Container(
          color: Theme.of(context).primaryColor,
          height: 50,
          child: const Center(
            child: Text('Swipe me!',style: TextStyle(color: Colors.white),),
          ),
        ),
        body: Container(
          color: Colors.white,
          height: 30,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: const Text('Urdu'),
                    leading: Radio<Translation>(
                      value: Translation.urdu,
                      groupValue: _translation,
                        onChanged: (Translation? value){
                        setState(() {
                          _translation=value;
                        });

                        },
                    ),
                  ),
                  ListTile(
                    title: const Text('Hindi'),
                    leading: Radio<Translation>(
                      value: Translation.hindi,
                      groupValue: _translation,
                      onChanged: (Translation? value) {
                        setState(() {
                          _translation = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('English'),
                    leading: Radio<Translation>(
                      value: Translation.english,
                      groupValue: _translation,
                      onChanged: (Translation? value) {
                        setState(() {
                          _translation = value;
                        });
                      },
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
