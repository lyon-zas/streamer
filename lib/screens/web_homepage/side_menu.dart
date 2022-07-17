import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  final Function onIndexChanged;
  final int selectedIndex;
  SideMenu(this.onIndexChanged, this.selectedIndex);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: Colors.black87,
        child: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 20),
              child: const Center(
                child: Text(
                  "OC",
                  style: TextStyle(fontSize: 32, color: Color(0x0FFf3035a)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedIndex == 0
                              ? Color(0xFFF3035A)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        selected: selectedIndex == 0,
                        leading: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        title: const Text("Users",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        onTap: () {
                          onIndexChanged(0);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedIndex == 1
                              ? Color(0xFFF3035A)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        selected: selectedIndex == 1,
                        leading: const Icon(
                          Icons.mail,
                          color: Colors.white,
                        ),
                        title: const Text("Mail",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        onTap: () {
                          onIndexChanged(1);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedIndex == 2
                              ? Color(0xFFF3035A)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        selected: selectedIndex == 2,
                        leading: const Icon(
                          Icons.play_circle_fill_rounded,
                          color: Colors.white,
                        ),
                        title: const Text("Users",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        onTap: () {
                          onIndexChanged(2);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedIndex == 3
                              ? Color(0xFFF3035A)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        selected: selectedIndex == 3,
                        leading: const Icon(
                          Icons.live_tv,
                          color: Colors.white,
                        ),
                        title: const Text("Live Stram",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        onTap: () {
                          onIndexChanged(3);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedIndex == 4
                              ? Color(0xFFF3035A)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        selected: selectedIndex == 4,
                        leading: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        title: const Text("Details",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        onTap: () {
                          onIndexChanged(4);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
