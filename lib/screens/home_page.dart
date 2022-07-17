import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:streamer/screens/mobile/drawer.dart';
import 'package:streamer/widgets/video_grid_item.dart';

import '../model/Livestream_model.dart';
import '../resources/firebase_methods.dart';
import '../utils/colors.dart';
import '../utils/video_categories.dart';
import '../widgets/home_screen_text_field.dart';
import 'broadcast_scren.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/homepage";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _fireStore = FirebaseFirestore.instance;
  final TextEditingController _searchBarEditingController =
      TextEditingController();
  int currentSelected = 0;
  late StreamSubscription videoStream;
  List<LiveStream> liveStreamList = [];

  streamList() async {
    videoStream =
        _fireStore.collection("livestream").snapshots().listen((snapshot) {
      final snapshotDocs = snapshot.docs;

      liveStreamList = snapshotDocs.map((item) {
        return LiveStream(
          title: item["title"],
          image: item["image"],
          uid: item["uid"],
          name: item["name"],
          viewers: item["viewers"],
          channelId: item["channelId"],
          startedAt: item["startedAt"],
        );
      }).toList();
      setState(() {});
      if (snapshot.docChanges.isNotEmpty) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    streamList();
  }

  @override
  void dispose() {
    videoStream.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              title: const Text("Video Management",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: "Titillium Web")),
              backgroundColor: kScaffoldBackgroundColor,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.menu_rounded,
                    color: Color(0xFFf3035a),
                  ),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const DrawerPage())),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23.0),
                child: homeScreenTextField(
                    controller: _searchBarEditingController)),
            const SizedBox(height: 5),
            SizedBox(
              width: size.width,
              height: 50, //kToolbarHeight - 15,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: videoCategories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          currentSelected = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          videoCategories[index],
                          style: TextStyle(
                            fontSize: 20,
                            color: currentSelected == index
                                ? primaryColor
                                : Colors.grey[500],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      //body: FeedScreen(),
      body: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: liveStreamList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (135 / 160),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                await FirestoreMethods()
                    .updateViewCount(liveStreamList[index].channelId, true);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BroadcastScreen(
                      isBroadcaster: false,
                      channelId: liveStreamList[index].channelId,
                    ),
                  ),
                );
              },
              child: videoGridItem(
                screenWidth: size.width,
                title: liveStreamList[index].title,
                streamer: liveStreamList[index].name,
                viewers: liveStreamList[index].viewers,
                startTime: liveStreamList[index].startedAt,
                imageUrl: liveStreamList[index].image,
              ),
            );
          }),
    );
  }
}
