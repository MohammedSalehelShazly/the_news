import 'package:flutter/material.dart';
import '../global/responsive.dart';

class TheNewsLogo extends StatelessWidget {
  final BuildContext ctx;
  final ValueKey keyVal;
  final String heroTag;

  const TheNewsLogo({
    @required this.ctx,
    @required this.keyVal,
    @required this.heroTag
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag, // not work because it  (Navigator.pushReplacement) ...not push
      child: Container(
        key: keyVal,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/the_news_logo.png'),
                  fit: BoxFit.contain,
                )
        ),
      ),
    );
  }
}