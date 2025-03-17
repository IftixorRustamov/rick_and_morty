import 'package:flutter/material.dart';

class BaseIndicator extends StatelessWidget {
  const BaseIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator.adaptive());
  }
}
