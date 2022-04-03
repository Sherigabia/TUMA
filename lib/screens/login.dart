import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
//import 'package:permission_handler/permission_handler.dart';
import 'package:tuma/models/user.dart';
import 'package:tuma/screens/forgotPassword.dart';
import 'package:tuma/screens/homeView.dart';
// import 'package:tuma/screens/mainPage.dart';
// import 'package:tuma/screens/newMain.dart';
import 'package:tuma/screens/registration.dart';
import 'package:tuma/models/user.dart';
import 'package:tuma/screens/forgotPassword.dart';
import 'package:tuma/screens/registration.dart';

late User user;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    //  _requestPermission();
    //requesEnableLocation();
  }

  // _requestPermission() async {
  //   var status = await Permission.location.request();
  //   if (status.isGranted) {
  //     print('done');
  //   } else if (status.isDenied) {
  //     _requestPermission();
  //   } else if (status.isPermanentlyDenied) {
  //     openAppSettings();
  //   }
  // }

  // Future<bool> requesEnableLocation() async {
  //   bool isShown = await Permission.contacts.shouldShowRequestRationale;
  //   if (!isShown) {
  //     showDialog(
  //         context: context,
  //         builder: (context) => new AlertDialog(
  //                 title: Text(
  //                   "Enable Location Access",
  //                   style: TextStyle(
  //                       color: Colors.black, fontWeight: FontWeight.bold),
  //                 ),
  //                 content: SingleChildScrollView(
  //                     child: ListBody(children: [
  //                   Text(
  //                       "Tow Ghana App collects location information to help Towing Trucks locate broken down vehicles or accident cars that have requested for a Tow Truck."),
  //                   Text(
  //                     "Location service is required only when the app is in use",
  //                     style: TextStyle(
  //                         color: Colors.black, fontWeight: FontWeight.bold),
  //                   )
  //                 ])),
  //                 actions: [
  //                   TextButton(
  //                     onPressed: () async {
  //                       var status = await Permission.location.request();
  //                       if (!status.isGranted) {
  //                         print('done');
  //                         openAppSettings();
  //                       }
  //                       Navigator.of(context).pop();
  //                     },
  //                     child: Text("Allow"),
  //                   ),
  //                   TextButton(
  //                       onPressed: () {
  //                         exit(0);
  //                       },
  //                       child: Text("Exit App"))
  //                 ]));
  //   }
  //   return true;
  // }
  // late User user;
  // end of the code
  bool processing = false;

  //form key
  final _formKey = GlobalKey<FormState>();

  //editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //get User Data

  getUserData() {}

  @override
  Widget build(BuildContext context) {
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
            prefixIcon: const Icon(Icons.mail),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Enter Email",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));

    //Password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
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
            prefixIcon: const Icon(Icons.vpn_key),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Enter Password",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));

    final loginButton = Material(
        elevation: 3,
        color: Color.fromRGBO(41, 205, 195, 1),
        borderRadius: BorderRadius.circular(5),
        child: MaterialButton(
            onPressed: () {
              signIn(emailController.text, passwordController.text);
            },
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
            minWidth: MediaQuery.of(context).size.width,
            child: processing == false
                ? const Text("Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold))
                : const CircularProgressIndicator(
                    backgroundColor: Colors.greenAccent,
                    semanticsLabel: 'Loading ..',
                  )));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: SizedBox(
                            child: Image.asset(
                          'assets/images/TumaLogo.png',
                          fit: BoxFit.contain,
                        )),
                      ),
                      const SizedBox(height: 25),
                      emailField,
                      const SizedBox(height: 25),
                      passwordField,
                      const SizedBox(height: 25),
                      loginButton,
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegistrationScreen()));
                            },
                            child: const Text("Register Here",
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15)),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //  Forgot password field
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPassword()));
                            },
                            child: const Text("Forgot Password ?",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }

//Login Function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        processing = true;
      });
      //  var url = Uri.parse('https://tuma.com/tg/api/user/login');
      var url =
          Uri.parse('https://tumaghana.com/Tuma/api/user/login'); // global URL

      var data = {
        'email': emailController.text,
        'password': passwordController.text,
      };
      var response = await http.post(url, body: data);
      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        var userData = responseData['user'];

        User authUser = User.fromJson(userData);

        setState(() {
          processing = false;
          user = authUser;
        });

        print(user);
        Fluttertoast.showToast(
            msg: 'Login Successful', toastLength: Toast.LENGTH_SHORT);

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeView()));
      } else {
        setState(() {
          processing = false;
        });

        Fluttertoast.showToast(
            msg: 'Login Failed!', toastLength: Toast.LENGTH_SHORT);
      }
    }
  }
}
