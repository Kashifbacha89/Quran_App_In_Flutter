import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
class PrayerTimingScreen extends StatefulWidget {
  const PrayerTimingScreen({Key? key}) : super(key: key);

  @override
  State<PrayerTimingScreen> createState() => _PrayerTimingScreenState();
}

class _PrayerTimingScreenState extends State<PrayerTimingScreen> {
  Location location=Location();
  LocationData? _currentPosition;
  double? latitude,longitude;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text('Prayer Timing',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getLoc(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          final myCoordinates=Coordinates(33.6938118,73.0651511);
          final params=CalculationMethod.karachi.getParameters();
          params.madhab=Madhab.hanafi;
          final prayerTimes=PrayerTimes.today(myCoordinates, params);
          return Padding(padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text('Fajar',style: GoogleFonts.acme(
                        textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                      )
                      ),
                      Text(DateFormat.jm().format(prayerTimes.fajr),
                        style: const TextStyle(
                        fontSize: 16,fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                ),
               const  Divider(thickness: 1,color: Colors.black,),
                Padding(padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('sunrise',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Text(DateFormat.jm().format(prayerTimes.sunrise),
                        style: const TextStyle(
                            fontSize: 16,fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),
                ),
                const Divider(thickness: 1,color: Colors.black,),
                Padding(padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Dhuhr',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Text(DateFormat.jm().format(prayerTimes.dhuhr),
                        style: const TextStyle(
                            fontSize: 16,fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),
                ),
               const  Divider(thickness: 1,color: Colors.black,),
                Padding(padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('asr',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Text(DateFormat.jm().format(prayerTimes.asr),
                        style: const TextStyle(
                            fontSize: 16,fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),
                ),
                const Divider(thickness: 1,color: Colors.black,),
                Padding(padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Maghrib',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Text(DateFormat.jm().format(prayerTimes.maghrib),
                        style: const TextStyle(
                            fontSize: 16,fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),
                ),
               const  Divider(thickness: 1,color: Colors.black,),
                Padding(padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Isha',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Text(DateFormat.jm().format(prayerTimes.isha),
                        style: const TextStyle(
                            fontSize: 16,fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),
                ),

              ],
            ),

          );
        },
      ),
    ));
  }



  getLoc()async {
    bool _serviceEnabled;
    PermissionStatus _permisionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if(!_serviceEnabled){
      _serviceEnabled=await location.requestService();
      if(_serviceEnabled){
        return;
      }
    }
    _permisionGranted = await location.hasPermission();
    if(_permisionGranted==PermissionStatus.denied){
      _permisionGranted= await location.requestPermission();
      if(_permisionGranted != PermissionStatus.granted){
        return;
      }
    }
    _currentPosition= await location.getLocation();
    latitude= _currentPosition!.latitude!;
    latitude= _currentPosition!.latitude;

  }
}

