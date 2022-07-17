import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:streamer/screens/mobile/drawer.dart';
import 'package:streamer/screens/web_homepage/web_homepage.dart';

import 'feedScreen.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/homepage";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar:
          // kIsWeb
          //     ? PreferredSize(
          //         child: Container(),
          //         preferredSize: Size.fromHeight(0),
          //       )
          // :
          PreferredSize(
        preferredSize: const Size.fromHeight(180.0),
        child: Column(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              title: const Text("Streamer",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontFamily: "Titillium Web")),
              backgroundColor: Colors.black,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.menu_rounded,
                    color: Color(0x0FFf3035a),
                  ),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const DrawerPage())),
                ),
              ],
            ),
            Column(children: [
              ListTile(
                title: TextField(
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    filled: true, //<-- SEE HERE
                    fillColor: Colors.grey.shade900,
                    hintText: 'search video...',
                    suffixIcon: const Icon(Icons.question_mark_rounded,
                        color: Colors.white),

                    hintStyle: const TextStyle(
                      color: Colors.white38,
                      fontSize: 13,
                    ),

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 3,
            ),
            Column(
              children: [
                SizedBox(
                  height: kToolbarHeight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        Text(
                          "Top",
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(width: 15),
                        Text("Trending",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 20,
                            )),
                        SizedBox(width: 15),
                        Text("Explore",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 20,
                            )),
                        SizedBox(width: 15),
                        Text("Music",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 20,
                            )),
                        SizedBox(width: 15),
                        Text("Gaming",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 20,
                            )),
                        SizedBox(width: 15),
                        Text("Sport",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 20,
                            )),
                        SizedBox(width: 15),
                        Text("Music",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 20,
                            )),
                        SizedBox(width: 15),
                        Text("Gaming",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 20,
                            )),
                        SizedBox(width: 15),
                        Text("Sport",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 20,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: FeedScreen(),
          //  GridView.count(
          //    crossAxisCount: 4,
          //    childAspectRatio: 1.0,
          //    padding: const EdgeInsets.all(4.0),
          //    mainAxisSpacing: 4.0,
          //    crossAxisSpacing: 4.0,
          //    children: <String>[
          //      'http://www.for-example.org/img/main/forexamplelogo.png',
          //      'http://www.for-example.org/img/main/forexamplelogo.png',
          //      'http://www.for-example.org/img/main/forexamplelogo.png',
          //      'http://www.for-example.org/img/main/forexamplelogo.png',
          //      'http://www.for-example.org/img/main/forexamplelogo.png',
          //      'http://www.for-example.org/img/main/forexamplelogo.png',
          //      'http://www.for-example.org/img/main/forexamplelogo.png',
          //      'http://www.for-example.org/img/main/forexamplelogo.png',
          //      'http://www.for-example.org/img/main/forexamplelogo.png',
          //      'http://www.for-example.org/img/main/forexamplelogo.png',
          //      'http://www.for-example.org/img/main/forexamplelogo.png',
          //    ].map((String url) {
          //      return GridTile(
          //          child: Image.network(url, fit: BoxFit.cover));
          //    }).toList()),
          // kIsWeb
          //     ? WebhomePage()
          // :
          // GridView.builder(
          //     itemCount: 10,
          //     // scrollDirection: Axis.vertical,
          //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2,
          //       childAspectRatio: 1.0,
          //       mainAxisSpacing: 4.0,
          //       crossAxisSpacing: 4.0,
          //     ),
          //     itemBuilder: (context, index) {
          //       return Padding(
          //         padding: const EdgeInsets.all(4.0),
          //         child: Stack(
          //           children: [
          //             Container(
          //               decoration: BoxDecoration(
          //                   color: Colors.grey,
          //                   borderRadius: BorderRadius.circular(15),
          //                   image: const DecorationImage(
          //                       fit: BoxFit.contain,
          //                       image: AssetImage(
          //                         "assets/out_1.png",
          //                       ))),
          //             ),
          //             Positioned.fill(
          //               top: MediaQuery.of(context).size.height / 3.2,
          //               child: Container(
          //                 alignment: Alignment.bottomCenter,
          //                 height: 20,
          //                 decoration: BoxDecoration(
          //                     color: Colors.grey.shade900,
          //                     borderRadius: const BorderRadius.only(
          //                         bottomLeft: Radius.circular(15),
          //                         bottomRight: Radius.circular(15))),
          //                 child: const Padding(
          //                   padding: EdgeInsets.all(4.0),
          //                   child: const Text(
          //                       "With the online text generator you can process your personal Lorem Ipsum enriching it with html elements that define its",
          //                       textAlign: TextAlign.center,
          //                       maxLines: 2,
          //                       style: TextStyle(color: Colors.white)),
          //                 ),
          //               ),
          //             )
          //           ],
          //         ),
          //       );
          //     }),
      // ]),
    );
  }
}
