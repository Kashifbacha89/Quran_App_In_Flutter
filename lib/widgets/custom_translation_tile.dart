import 'package:flutter/material.dart';
import 'package:quran_app/constraints/constants.dart';
import 'package:quran_app/models/translation.dart';

class TranslationCustomTile extends StatelessWidget {
  const TranslationCustomTile(
      {Key? key, required this.index, required this.surahTranslation})
      : super(key: key);
  final int index;
  final SurahTranslation surahTranslation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(blurRadius: 3),
            ],
            borderRadius: BorderRadius.circular(8),
            shape: BoxShape.rectangle,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                      color: Constants.myPrimary,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                    ),
                  ),
                  Positioned(
                      top: 3,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: Text(
                          surahTranslation.aya!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                      ))
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      surahTranslation.arabic_text!,
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      surahTranslation.translation!,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
