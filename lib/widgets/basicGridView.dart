import 'package:flutter/material.dart';
import 'package:fullscreen/fullscreen.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class BasicGridWidget extends StatelessWidget {
  final String imgUrl;
  BasicGridWidget({Key? key, required this.imgUrl}) : super(key: key);
  void enterFullScreen(FullScreenMode fullScreenMode) async {
    await FullScreen.enterFullScreen(fullScreenMode);
  }

  void exitFullScreen() async {
    await FullScreen.exitFullScreen();
  }

  @override
  Widget build(BuildContext context) => StaggeredGridView.countBuilder(
        staggeredTileBuilder: (index) => index % 7 == 0
            ? StaggeredTile.count(2, 2)
            : StaggeredTile.count(1, 1),
        // StaggeredTile.count(2, index.isEven ? 2 : 1),
        shrinkWrap: true,
        primary: false,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        crossAxisCount: 3,
        itemCount: 50,
        itemBuilder: (context, index) => buildImageCard(index),
      );

  Widget buildImageCard(int index) => InkWell(
        onTap: () async {
          enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
        },
        child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            margin: EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imgUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
}
