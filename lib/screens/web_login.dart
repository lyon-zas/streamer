import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../resources/auth_method.dart';
import 'home_page.dart';
import 'web_homepage/web_homepage.dart';

class WebLogin extends StatefulWidget {
  static const routeName = "/weblogin";
  const WebLogin({Key? key}) : super(key: key);

  @override
  _WebLoginState createState() => _WebLoginState();
}

class _WebLoginState extends State<WebLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool value = false;
  final AuthMethods _authMethods = AuthMethods();
  bool _isLoading = false;

  loginUser() async {
    setState(() {
      _isLoading = true;
    });
    bool res = await _authMethods.loginUser(
      context,
      _emailController.text,
      _passwordController.text,
    );
    setState(() {
      _isLoading = false;
    });
    if (res) {
      Navigator.pushReplacementNamed(context, WebhomePage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Image.asset(
          "assets/cover.jpg",
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.fill,
        ),
        Container(
          color: Colors.black,
          width: MediaQuery.of(context).size.width / 2,
          child: Center(
            child: Padding(
              padding: MediaQuery.of(context).size.width > 600?
              const EdgeInsets.all(100):const EdgeInsets.all(5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 35,
                      child: Center(
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.white30,
                          controller: _emailController,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w300),
                          decoration: InputDecoration(
                              hintText: "sample@gmail.com",
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      color: Colors.grey,
                                      style: BorderStyle.solid)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      color: Colors.white,
                                      style: BorderStyle.solid)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      color: Colors.grey,
                                      style: BorderStyle.solid)),
                              hintStyle:
                                  const TextStyle(color: Colors.white30)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 35,
                      child: Center(
                        child: TextField(
                          keyboardType: TextInputType.visiblePassword,
                          cursorColor: Colors.white30,
                          controller: _passwordController,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w300),
                          decoration: InputDecoration(
                              hintText: "password",
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      color: Colors.grey,
                                      style: BorderStyle.solid)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      color: Colors.white,
                                      style: BorderStyle.solid)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      color: Colors.grey,
                                      style: BorderStyle.solid)),
                              hintStyle:
                                  const TextStyle(color: Colors.white30)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () => loginUser(),
                        child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 50,
                            child: const Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color(0x0FFf3035a))),
                      ),
                    ),
                  ]),
            ),
          ),
        )
      ],
    ));
  }
}
