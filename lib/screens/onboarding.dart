import 'package:flutter/material.dart';
import 'package:tuma/screens/homeView.dart';
import 'package:tuma/widgets/animatedIndicator.dart';
import 'package:lottie/lottie.dart';

const KTitleStyle =
    TextStyle(fontSize: 27, color: Colors.blue, fontWeight: FontWeight.bold);
const KSubtitleStyle = TextStyle(
  fontSize: 20,
  color: Color(0xFF88869f),
);

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final pageController = new PageController(initialPage: 0);

    void nextPage() {
      pageController.nextPage(
          duration: const Duration(milliseconds: 200), curve: Curves.ease);
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Container(
                child: PageView(
          controller: pageController,
          children: [
            Slide(
              hero: Lottie.asset("assets/images/confuse-person.json"),
              title: "NEED HELP ?",
              subtitle: "Do you need the services of a proffesional worker?",
              onNext: nextPage,
            ),
            Slide(
              hero: Lottie.asset("assets/images/search-for-employee.json"),
              title: "Browse Our List ",
              subtitle:
                  "Browse through our list of numerous and qualified proffesional workers near you. ",
              onNext: nextPage,
            ),
            Slide(
              hero: Lottie.asset("assets/images/plumbers.json"),
              title: "Quality Service Assured ",
              subtitle:
                  "By requesting for the services of our proffesional workers, quality work service is assured",
              onNext: nextPage,
            ),
            // Slide(
            //     hero: Lottie.asset("assets/images/working-people.json"),
            //     title: "CAR TOWING SERVICE",
            //     subtitle: "We provide on demand car towing services",
            //     onNext: nextPage),
            // Slide(
            //     hero: Lottie.asset("assets/images/working-day.json"),
            //     title: "CAR TOWING SERVICE",
            //     subtitle: "We provide on demand car towing services",
            //     onNext: nextPage),
            // Slide(
            //     hero: Lottie.asset("assets/images/working.json"),
            //     title: "CAR TOWING SERVICE",
            //     subtitle: "We provide on demand car towing services",
            //     onNext: nextPage),
            Slide(
                hero: Lottie.asset("assets/images/support.json"),
                title: "24/7 SUPPORT",
                subtitle:
                    "We provide excellent customer support service. Contact us today",
                onNext: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeView()),
                      (route) => false);
                }),
          ],
        ))));
  }
}

class Slide extends StatelessWidget {
  final Widget hero;
  final String title, subtitle;
  final VoidCallback onNext;

  const Slide({
    Key? key,
    required this.hero,
    required this.title,
    required this.subtitle,
    required this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Expanded(
        child: hero,
      ),
      Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Text(title, style: KTitleStyle),
            SizedBox(height: 10),
            Text(subtitle, style: KSubtitleStyle, textAlign: TextAlign.center),
            SizedBox(height: 25),
            ProgressButton(
              onNext: onNext,
            ),
          ])),
      GestureDetector(
        onTap: onNext,
        child: Text(
          'Skip',
          style: KSubtitleStyle,
        ),
      ),
      SizedBox(
        height: 4,
      ),
    ]));
  }
}

class ProgressButton extends StatelessWidget {
  final VoidCallback onNext;
  const ProgressButton({Key? key, required this.onNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      width: 75,
      child: Stack(
        children: [
          AnimatedIndicator(
              duration: const Duration(seconds: 10),
              size: 75,
              callback: onNext),
          Center(
              child: GestureDetector(
            child: Container(
                height: 60,
                width: 60,
                child: Center(
                    child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                )),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(99),
                )),
            onTap: onNext,
          ))
        ],
      ),
    );
  }
}
