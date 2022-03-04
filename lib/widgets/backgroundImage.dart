import 'package:flutter/material.dart';

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
