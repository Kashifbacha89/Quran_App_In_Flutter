import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/models/qari.dart';
class QariCustomTile extends StatefulWidget {
  const QariCustomTile({Key? key,
  required this.qari,
    required this.ontap
  }) : super(key: key);
  final Qari qari;
  final VoidCallback ontap;

  @override
  State<QariCustomTile> createState() => _QariCustomTileState();
}

class _QariCustomTileState extends State<QariCustomTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Padding(
        padding:const  EdgeInsets.all(4.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                blurRadius: 3,
                spreadRadius: 0.0,
                color: Colors.black12,
                offset: Offset(0, 1),

              )
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.qari.name!,textAlign: TextAlign.start,
              style: GoogleFonts.abel(
                textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
              ),)

            ],
          ),
        ),
      ),
    );
  }
}
