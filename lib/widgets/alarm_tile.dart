import 'package:flutter/material.dart';

class ExampleAlarmTile extends StatelessWidget {
  const ExampleAlarmTile({
    required this.title,
    required this.alarmTitle,
    required this.onPressed,
    super.key,
    this.onDismissed,
  });

  final String title;
  final String alarmTitle;
  final void Function() onPressed;
  final void Function()? onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key!,
      direction: onDismissed != null
          ? DismissDirection.endToStart
          : DismissDirection.none,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 30),
        child: const Icon(
          Icons.delete,
          size: 30,
          color: Colors.white,
        ),
      ),
      onDismissed: (_) => onDismissed?.call(),
      child: RawMaterialButton(
        onPressed: onPressed,
        child: Container(
          color: Colors.blue[100]!.withOpacity(0.3),
          height: 140,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    alarmTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_right_rounded, size: 35),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
