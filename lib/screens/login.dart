import 'package:flutter/material.dart';
import 'package:streamer/screens/home_page.dart';
import 'package:streamer/screens/signup.dart';
import 'package:streamer/widgets/authentication_text_field.dart';

import '../resources/auth_method.dart';

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
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/cover.jpg"),
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    )),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
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
                        authenticationTextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            hintText: "Sample@mail.com",
                            label: "Email"),
                        authenticationTextField(
                            controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            hintText: "Password",
                            label: "Password"),
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
                                    color: const Color(0xFFf3035a))),
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
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const SignUp())),
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
                ),
              ),
            )
          ],
        ));
  }
}
