import 'package:flutter/material.dart';
import 'package:tuma/screens/homeView.dart';
import 'package:tuma/screens/login.dart';
//import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _mockloadSplash().then((status) {
      if (status) {
        if (status) {
          _navigateHome();
        }
      }
    });
  }

  Future<bool> _mockloadSplash() async {
    await Future.delayed(const Duration(milliseconds: 5000), () {});

    return true;
  }

  void _navigateHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen( )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(alignment: Alignment.center, children: [
        Center(
          child: Container(
              child: Image.asset(
            "assets/images/Tuma.jpg",
            fit: BoxFit.cover,
          )),
        ),
        // Opacity(opacity: 0.5, child: Image.asset("assets/images/bg.png")),
      ]),
    );
  }
}
