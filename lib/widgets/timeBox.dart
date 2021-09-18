import 'package:flutter/material.dart';

import '../services/providers/themeProv.dart';

import 'package:provider/provider.dart';

class TimeBox extends StatelessWidget {
  Widget child;
  TimeBox(this.child);

  @override
  Widget build(BuildContext context) {
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
