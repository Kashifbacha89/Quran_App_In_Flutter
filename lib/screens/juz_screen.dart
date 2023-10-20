import 'package:flutter/material.dart';
import 'package:quran_app/constraints/constants.dart';
import 'package:quran_app/models/juz_model.dart';
import 'package:quran_app/services/api_service.dart';

import '../widgets/juz_custom_tile.dart';

class JuzScreen extends StatelessWidget {
  static const String id = 'juz_screen';

  ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<JuzModel>(
          future: apiServices.getJuz(Constants.juzIndex!),
          builder: (context, AsyncSnapshot<JuzModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(),);
            } else if(snapshot.hasData){
              print('${snapshot.data!.juzAyahs.length} length');
              return ListView.builder(
                itemCount: snapshot.data!.juzAyahs.length,
                itemBuilder: (context, index) {
                  return JuzCustomTile(list: snapshot.data!.juzAyahs,index: index,);
                },
              );
            }
            else{
              return const Center(child: Text('Data not found'),);
            }
          },
        ),
      ),
    );
  }

}