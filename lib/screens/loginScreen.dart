import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuma/screens/homeView.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // end of the code
  bool processing = false;
//form key
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //editing controller

//email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please Enter your Email";
          }
          //reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return " Please Enter a valid E-mail";
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(Icons.mail),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Enter Email",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));

    //Password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return "Password required";
          }
          if (!regex.hasMatch(value)) {
            return "Enter a Valid Password (Min. 6 Characters)";
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(Icons.vpn_key),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Enter Password",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));
    final loginButton = Material(
        elevation: 5,
        color: Color.fromRGBO(41, 205, 195, 1),
        borderRadius: BorderRadius.circular(5),
        child: MaterialButton(
            onPressed: () {
              signIn(emailController.text, passwordController.text);
            },
            padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
            minWidth: MediaQuery.of(context).size.width,
            child: processing == false
                ? Text("LOGIN",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)))
                : CircularProgressIndicator(
                    backgroundColor: Colors.greenAccent,
                    semanticsLabel: 'Loading ..',
                  )));

    return BackgroundImage(
      image: const AssetImage("assets/images/worker.jpg"),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(children: [
              Padding(
                padding: EdgeInsets.only(top: 75.0),
                child: Text(
                  "LOGIN",
                  style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 72,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Enter your credentials to login",
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400)),
              ),
              const SizedBox(height: 45),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      emailField,
                      SizedBox(height: 25),
                      passwordField,
                      SizedBox(height: 35),
                      loginButton
                    ],
                  ))
            ]),
          )),
    );
  }

//Login Function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeView()));
    }
  }
}

// ShaderMask(
//       shaderCallback: (bounds) => const LinearGradient(
//               colors: [Colors.black38, Colors.black87],
//               begin: Alignment.center,
//               end: Alignment.bottomCenter)
//           .createShader(bounds),

// return
class BackgroundImage extends StatelessWidget {
  final Widget child;
  final ImageProvider image;
  const BackgroundImage({Key? key, required this.child, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Stack(children: [buildBackground(), child]);

  Widget buildBackground() => ShaderMask(
        blendMode: BlendMode.darken,
        shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.black38, Colors.black87],
                begin: Alignment.center,
                end: Alignment.bottomCenter)
            .createShader(bounds),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.darken),
                  image: image,
                  fit: BoxFit.cover)),
        ),
      );
}
