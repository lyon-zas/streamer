import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:streamer/responsive/responsive.dart';
import 'package:streamer/screens/home_page.dart';
import 'package:streamer/screens/web_homepage/Sidebar_pages/email.dart';
import 'package:streamer/screens/web_homepage/Sidebar_pages/live_stream.dart';
import 'package:streamer/screens/web_homepage/Sidebar_pages/users.dart';
import 'package:streamer/screens/web_homepage/Sidebar_pages/video.dart';

// import '../live_streaming/pages/stream_homepage.dart';
import '../../widgets/loading_indicator.dart';
import 'Sidebar_pages/persons.dart';
import 'side_menu.dart';

class WebhomePage extends StatefulWidget {
  static const routeName = "/webhomepage";
  const WebhomePage({Key? key}) : super(key: key);

  @override
  _WebhomePageState createState() => _WebhomePageState();
}

class _WebhomePageState extends State<WebhomePage> {
  int selectedIndex = 0;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_isLoading
          ? const LoadingIndicator(): SafeArea(
          child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
          Expanded(
              flex: 2,
              child: SideMenu((int index) {
                setState(() {
                  selectedIndex = index;
                });
              }, selectedIndex)),
          Expanded(
              flex: 10,
              child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  // color: Colors.black,
                  child: Builder(builder: (context) {
                    if (selectedIndex == 0) {
                      return const Persons();
                    }
                    if (selectedIndex == 1) {
                      return const UserEmails();
                    }
                    if (selectedIndex == 2) {
                      return const Videos();
                    }
                    if (selectedIndex == 3) {
                      return  LiveStream();
                    }
                    if (selectedIndex == 4) {
                      return const UsersPage();
                    }
                    return Container();
                  }))),
                ],
              )),
    );
  }
}
