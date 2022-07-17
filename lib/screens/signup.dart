import 'package:flutter/material.dart';
import 'package:streamer/screens/home_page.dart';
import 'package:streamer/screens/login.dart';

import '../resources/auth_method.dart';
import '../widgets/loading_indicator.dart';

class SignUp extends StatefulWidget {
  static const routeName = "/signup";
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthMethods _authMethods = AuthMethods();
  bool _isLoading = false;
  bool value = false;

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

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    bool res = await _authMethods.signUpUser(
      context,
      _emailController.text,
      _nameController.text,
      _passwordController.text,
    );
    setState(() {
      _isLoading = false;
    });
    if (res) {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:_isLoading
          ? const LoadingIndicator(): ListView(
        children: [
          Positioned(
              top: 0.0,
              child: Container(
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
              )),
          //  Positioned(
          //     top:1,
          //     left: 1,
          //     child: IconButton(
          //         icon: Icon(Icons.arrow_back_ios_new),
          //         onPressed: () {
          //           Navigator.pop(context);
          //         }),
          //   ),
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
                          "Sign UP",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 5),
                        child:
                            Text("Name", style: TextStyle(color: Colors.white)),
                      ),
                      TextField(
                        keyboardType: TextInputType.name,
                        cursorColor: Colors.white30,
                        controller: _nameController,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w300),
                        decoration: const InputDecoration(
                            hintText: "John snow",
                            focusColor: Colors.white30,
                            hoverColor: Colors.white30,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white30)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white30)),
                            hintStyle: TextStyle(color: Colors.white30)),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 5),
                        child: Text("Email",
                            style: TextStyle(color: Colors.white)),
                      ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        cursorColor: Colors.white30,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w300),
                        decoration: InputDecoration(
                            hintText: "sample@gmail.com",
                            focusColor: Colors.white30,
                            hoverColor: Colors.white30,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white30)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white30)),
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
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        cursorColor: Colors.white30,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w300),
                        decoration: InputDecoration(
                            hintText: "password",
                            focusColor: Colors.white30,
                            hoverColor: Colors.white30,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white30)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white30)),
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
                                  fillColor: MaterialStateProperty.resolveWith(
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
                          onTap: () {
                            signUpUser();
                          },
                          child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: 50,
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(color: Colors.white),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color(0x0FFf3035a))),
                        ),
                      ),
                    ]),
              ))
        ],
      ),
    );
  }
}
