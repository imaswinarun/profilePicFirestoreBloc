import 'package:flutter/material.dart';

class BuildCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarText;
  final AppBar appBar;

  BuildCustomAppBar(this.appBarText, this.appBar);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("$appBarText"),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
