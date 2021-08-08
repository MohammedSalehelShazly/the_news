import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/providers/themeProv.dart';

class TimeBox extends StatelessWidget {
  Widget child;
  TimeBox(this.child);

  ThemeProv themeProv;
  bool first = true;

  @override
  Widget build(BuildContext context) {
    if(first){
      themeProv = Provider.of<ThemeProv>(context);
      first = false;
    }
    return Container(
      padding: EdgeInsets.only(right: 0),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Container(
            decoration: BoxDecoration(
                border: Border.all(),
                shape: BoxShape.circle
            ),
            child: Icon(Icons.access_time),
          ),

          child ,

        ],
      ),
    );
  }
}
