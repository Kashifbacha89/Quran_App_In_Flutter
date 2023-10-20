import 'package:flutter/material.dart';
import 'package:quran_app/models/qari.dart';
import 'package:quran_app/screens/audio_surah_screen.dart';
import 'package:quran_app/services/api_service.dart';
import 'package:quran_app/widgets/qari_custom_tile.dart';

class QariListScreen extends StatefulWidget {
  const QariListScreen({Key? key}) : super(key: key);

  @override
  State<QariListScreen> createState() => _QariListScreenState();
}

class _QariListScreenState extends State<QariListScreen> {
  ApiServices qariListApis = ApiServices();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Qari\'s'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 12,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 3, spreadRadius: 0.0, offset: Offset(0, 1))
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Text('Search'),
                    Spacer(),
                    Icon(Icons.search)
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: FutureBuilder(
              future: qariListApis.getQariList(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Qari>> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Qari\'s data not found '),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return QariCustomTile(
                            qari: snapshot.data![index], ontap: () {

                              Navigator.push(context, MaterialPageRoute(builder: (_)=>
                              AudioSurahScreen(qari:snapshot.data![index])
                              ));
                        });
                      });
                }
              },
            ))
          ],
        ),
      ),
    ));
  }
}
