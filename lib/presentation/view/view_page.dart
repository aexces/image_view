import 'package:flutter/material.dart';

class ViewPage extends StatelessWidget {
  const ViewPage(this.imageUrl, {Key? key}) : super(key: key);
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
