import 'package:flutter/material.dart';
import 'package:streamer/screens/home_page.dart';
import 'package:streamer/screens/signup.dart';
import 'dart:io';
import "package:flutter/foundation.dart" show kIsWeb;
import 'package:streamer/screens/web_login.dart';

import '../resources/auth_method.dart';
import 'web_homepage/web_homepage.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/loginscreen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    }
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.grey;
    }
    return Colors.white;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: //kIsWeb
            // ? const WebLogin()
            //:
            ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/cover.jpg"),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )),
            ),
            Positioned.fill(
                top: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        const Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 5),
                          child: Text("Email",
                              style: TextStyle(color: Colors.white)),
                        ),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.white30,
                          controller: _emailController,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w300),
                          decoration: const InputDecoration(
                              hintText: "sample@gmail.com",
                              focusColor: Colors.white30,
                              hoverColor: Colors.white30,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white30)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white30)),
                              hintStyle: TextStyle(color: Colors.white30)),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 5),
                          child: Text(
                            "password",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextField(
                          keyboardType: TextInputType.visiblePassword,
                          cursorColor: Colors.white30,
                          controller: _passwordController,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w300),
                          decoration: const InputDecoration(
                              hintText: "password",
                              focusColor: Colors.white30,
                              hoverColor: Colors.white30,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white30)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white30)),
                              hintStyle: TextStyle(color: Colors.white30)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Checkbox(
                                    checkColor:
                                        Colors.black, // color of tick Mark
                                    activeColor: Colors.white,
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                            getColor),
                                    value: this.value,
                                    onChanged: (value) {
                                      setState(() {
                                        this.value = value!;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text("check",
                                      style: TextStyle(color: Colors.white))
                                ]),
                                const Text("Remind password",
                                    style: TextStyle(color: Colors.white))
                              ]),
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
                                    color: Color(0x0FFf3035a))),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Don't have an account? Register",
                                  style: TextStyle(color: Colors.white)),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: MaterialButton(
                                  minWidth:
                                      MediaQuery.of(context).size.width / 1.2,
                                  padding: const EdgeInsets.all(0),
                                  height: 50,
                                  onPressed: ()=> Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SignUp())),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: const BorderSide(
                                        width: 1, color: Colors.white),
                                  ),
                                  child: Text(
                                    "Sign Up",
                                    style: Theme.of(context)
                                        .textTheme
                                        .button!
                                        .copyWith(color: Colors.white),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ]),
                ))
          ],
        ));
  }
}
