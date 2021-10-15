import 'package:flutter/material.dart';

class BuildNetworkImage extends StatelessWidget {
  final String url;

  BuildNetworkImage(this.url);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 16.0,
      shape: CircleBorder(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: FadeInImage.assetNetwork(
          fit: BoxFit.fill,
          height: 100.0,
          width: 100.0,
          placeholder: 'assets/gif/loading.gif',
          image: url,
          imageErrorBuilder: (context, exception, stacktree) {
            return Image.asset(
              "assets/images/profilePic.png",
              fit: BoxFit.fill,
              height: 100.0,
              width: 100.0,
            );
          },
        ),
      ),
    );
  }
}
