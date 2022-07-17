import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:streamer/model/Livestream_model.dart';

import 'package:timeago/timeago.dart' as timeago;

import '../resources/firebase_methods.dart';
import '../responsive/responsive_layout.dart';
import '../widgets/loading_indicator.dart';
import 'broadcast_scren.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: 
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(
          top: 10,
        ),
        child: Column(
          children: [
            // const Text(
            //   'Live Users',
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 22,
            //     color: Colors.white
            //   ),
            // ),
            SizedBox(height: size.height * 0.05),
            StreamBuilder<dynamic>(
              stream: FirebaseFirestore.instance
                  .collection('livestream')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingIndicator();
                }

                return Expanded(
                  child: ResponsiveLatout(
                    desktopBody: GridView.builder(
                      itemCount: snapshot.data.docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (context, index) {
                        LiveStream post = LiveStream.fromMap(
                            snapshot.data.docs[index].data());
                        return InkWell(
                          onTap: () async {
                            await FirestoreMethods()
                                .updateViewCount(post.channelId, true);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => BroadcastScreen(
                                  isBroadcaster: false,
                                  channelId: post.channelId,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 7,
                              horizontal: 7,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: size.height * 0.3,
                                  // width: size.height *0.35,
                                  child: Image.network(
                                    post.image,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                // const SizedBox(width: 5),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      post.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      post.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text('${post.viewers} watching',style: TextStyle(color: Colors.white,),),
                                    // Text("Live",style:TextStyle(color: Colors.red)),
                                    Text(
                                      'Startted ${timeago.format(post.startedAt.toDate())}',
                                      style: TextStyle(color: Colors.white,),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    mobileBody: GridView.builder(
                        itemCount: snapshot.data.docs.length,
                        gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                        itemBuilder: (context, index) {
                          LiveStream post = LiveStream.fromMap(
                              snapshot.data.docs[index].data());

                          return InkWell(
                            onTap: () async {
                              await FirestoreMethods()
                                  .updateViewCount(post.channelId, true);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => BroadcastScreen(
                                    isBroadcaster: false,
                                    channelId: post.channelId,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 7,
                              horizontal: 7,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: size.height * 0.27,
                                  // width: size.width *0.5,
                                  child: Image.network(
                                    post.image,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      post.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      post.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text('${post.viewers} watching',style: TextStyle(color: Colors.white,),),
                                    // Text("Live",style:TextStyle(color: Colors.red)),
                                    Text(
                                      'Startted ${timeago.format(post.startedAt.toDate())}',
                                      style: TextStyle(color: Colors.white,),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          );
                        }),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}