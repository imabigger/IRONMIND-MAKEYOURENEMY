import 'package:flutter/material.dart';

class SubText extends StatelessWidget {
  final String content;

  const SubText({required this.content,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      textAlign: TextAlign.right,
      style: const TextStyle(
        fontFamily: 'oswald',
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      ),
    );
  }
}
