import 'package:flutter/material.dart';

import '../../feedScreen.dart';

class Videos extends StatefulWidget {
  const Videos({Key? key}) : super(key: key);

  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FeedScreen(),
    );
  }
}
