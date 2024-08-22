import 'package:flutter/material.dart';

// ignore: must_be_immutable
class weatherCard extends StatelessWidget {
  weatherCard(
      {super.key, required this.text, required this.icon, required this.value});
  String text;
  String value;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height / 5,
      width: MediaQuery.sizeOf(context).width / 5,
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.5),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      margin: const EdgeInsets.all(8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            Icon(icon, color: Colors.white),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
