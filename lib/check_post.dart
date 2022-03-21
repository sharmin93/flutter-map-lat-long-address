import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ud_design/ud_design.dart';

import 'location_page.dart';

class CheckPost extends StatefulWidget {
  const CheckPost({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CheckPost> createState() => _CheckPostState();
}

class _CheckPostState extends State<CheckPost> {
  @override
  Widget build(BuildContext context) {
    UdDesign.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const LocationPage(),
    );
  }
}
