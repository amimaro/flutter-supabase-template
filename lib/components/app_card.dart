import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget children;

  const AppCard({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 400,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: children),
            )));
  }
}
