import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:tuma/screens/login.dart';
import 'package:date_time_picker/date_time_picker.dart';
//import 'package:tuma/screens/mainPage.dart';
//import 'package:tuma/api/api.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool processing = false;

  //auth
  // final _auth = FirebaseAuth.instance;
  // form key
  final _formKey = GlobalKey<FormState>();

  //editing controllers

  final firstNameEditingController = TextEditingController();
  final lastNameEditingController = TextEditingController();
  final dateOfBirthEditingController = TextEditingController();
  final phoneNumberEditingController = TextEditingController();
  final momoNumberEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  _registerUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        processing = true;
      });

      var url =
          Uri.parse('http://3bcc-154-160-2-31.ngrok.io/Tuma/api/user/register');

      var data = {
        "firstname": firstNameEditingController.text,
        "lastname": lastNameEditingController.text,
        "dob": dateOfBirthEditingController.text,
        "phone_number": phoneNumberEditingController.text,
        "momo_number": momoNumberEditingController.text,
        "email": emailEditingController.text,
        "password": passwordEditingController.text,
      };
      var response = await http.post(url, body: data);
      if (response.statusCode == 200) {
        setState(() {
          processing = false;
        });
        Fluttertoast.showToast(
            msg: 'Account Successfully Created',
            toastLength: Toast.LENGTH_SHORT);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        setState(() {
          processing = false;
        });
        Fluttertoast.showToast(
            msg: 'Error Occured!', toastLength: Toast.LENGTH_SHORT);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //firstName
    final firstNameField = TextFormField(
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return "First Name is required !";
          }
          if (!regex.hasMatch(value)) {
            return "Enter Valid Name (Min. 3 Characters)";
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_circle),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "First Name",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));

    //lastName
    final lastNameField = TextFormField(
        autofocus: false,
        controller: lastNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return "Last Name is required !";
          }
          return null;
        },
        onSaved: (value) {
          lastNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_circle),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Last Name",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));

    // Phone Number
    final phoneNumberField = TextFormField(
        autofocus: false,
        controller: phoneNumberEditingController,
        keyboardType: TextInputType.phone,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{10,}$');
          if (value!.isEmpty) {
            return "Phone Number required!";
          }
          if (!regex.hasMatch(value)) {
            return "Enter a Valid Phone Number ";
          }
        },
        onSaved: (value) {
          phoneNumberEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.phone_android),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Phone Number",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));
    // Phone Number
    final momoNumberField = TextFormField(
        autofocus: false,
        controller: momoNumberEditingController,
        keyboardType: TextInputType.phone,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{10,}$');
          if (value!.isEmpty) {
            return "Mobile Money Number required!";
          }
          if (!regex.hasMatch(value)) {
            return "Enter a Valid Phone Number ";
          }
        },
        onSaved: (value) {
          phoneNumberEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.phone_android),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Mobile Money Number",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));

    //email
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
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
          emailEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.mail),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Email",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));

//Date of birth field

    final dateOfBirth = DateTimePicker(
        type: DateTimePickerType.date,
        dateHintText: "Select Date of Birth",
        dateMask: 'd MMM, yyyy',
        // initialValue: DateTime.now().toString(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        icon: Icon(Icons.event),
        dateLabelText: 'Date',
        onChanged: (value) => print(value),
        validator: (value) {
          if (value!.isEmpty) {
            return "Date Of Birth is required !";
          }
          print(value);
          return null;
        },
        onSaved: (value) {
          dateOfBirthEditingController.text = value!;
        },
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.event),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Date of birth",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));
    //Password
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
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
          passwordEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.vpn_key),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Password",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));

    // Confirm Password
    final confirmPasswordField = TextFormField(
        autofocus: false,
        obscureText: true,
        controller: confirmPasswordEditingController,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Passwords do not match";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.vpn_key),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Confirm Password",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));

    // Register Button

    final registerButton = Material(
        elevation: 5,
        color: Color.fromRGBO(41, 205, 195, 1),
        borderRadius: BorderRadius.circular(5),
        child: MaterialButton(
            onPressed: () {
              _registerUser();
              // signUp(
              //     emailEditingController.text, passwordEditingController.text);
            },
            padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
            minWidth: MediaQuery.of(context).size.width,
            child: processing == false
                ? Text("Register",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold))
                : CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  )));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.red,
            )),
      ),
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
                          height: 200,
                          child: Image.asset(
                            'assets/images/Tuma.jpg',
                            fit: BoxFit.contain,
                          )),
                      SizedBox(height: 5),
                      firstNameField,
                      SizedBox(height: 20),
                      lastNameField,
                      SizedBox(height: 20),
                      dateOfBirth,
                      SizedBox(height: 20),
                      phoneNumberField,
                      SizedBox(height: 20),
                      momoNumberField,
                      SizedBox(height: 20),
                      emailField,
                      SizedBox(height: 20),
                      passwordField,
                      SizedBox(height: 20),
                      confirmPasswordField,
                      SizedBox(height: 20),
                      registerButton,
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }

  // void signUp(String email, String password) async {
  //   if (_formKey.currentState!.validate()) {
  //     await _auth
  //         .createUserWithEmailAndPassword(email: email, password: password)
  //         .then((value) => {postDetailsToFirestore()})
  //         .catchError((e) => {Fluttertoast.showToast(msg: e!.message)});
  //   }
  // }

  //Post details to firestore

  // postDetailsToFirestore() async {
  //   // calling firestore
  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   User? user = _auth.currentUser;

  //   // calling user model
  //   UserModel userModel = UserModel();

  //   //writing all the values
  //   userModel.email = user!.email;
  //   userModel.uid = user.uid;
  //   userModel.firstName = firstNameEditingController.text;
  //   userModel.lastName = lastNameEditingController.text;
  //   userModel.phoneNumber = phoneNumberEditingController.text;

  //   // send the values

  //   await firebaseFirestore
  //       .collection("users")
  //       .doc(user.uid)
  //       .set(userModel.toMap());
  //   Fluttertoast.showToast(msg: "Account Successfully Created");

  //   Navigator.pushAndRemoveUntil(
  //       (context),
  //       MaterialPageRoute(builder: (context) => HomeScreen()),
  //       (route) => false);
  // }

}
