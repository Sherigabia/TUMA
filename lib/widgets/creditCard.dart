import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  final Function onTopRightButtonClicked;
  final Gradient backgroundGradient;
  final String jobTitle;
  final String imgUrl;
  const CreditCard({
    Key? key,
    required this.jobTitle,
    required this.imgUrl,
    required this.onTopRightButtonClicked,
    this.backgroundGradient =
        const LinearGradient(colors: [Colors.black87, Colors.black54]),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        gradient: backgroundGradient,
        image: DecorationImage(
            fit: BoxFit.fitWidth,
            colorFilter:
                const ColorFilter.mode(Colors.black12, BlendMode.darken),
            image: AssetImage(imgUrl)),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  primary: Colors.white,
                ),
                onPressed: () {},
                child: Text(
                  jobTitle,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: IconButton(
                icon: const Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  onTopRightButtonClicked();
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "View $jobTitle",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const Text(
                    '',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
