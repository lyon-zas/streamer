import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget videoGridItem({
  required double screenWidth,
  required String title,
  required String streamer,
  required int viewers,
  required String imageUrl,
  required dynamic startTime,
}) {
  return Container(
    width: screenWidth * 0.38,
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(7),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 115,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(7),
              topLeft: Radius.circular(7),
            ),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 8),
          child: Text(
            "Title: $title\n"
            "Streamer: $streamer\n"
            "Viewers: $viewers watching\n"
            "Started: ${timeago.format(startTime.toDate())}",
            style: const TextStyle(color: Colors.white54),
          ),
        ),
      ],
    ),
  );
}
