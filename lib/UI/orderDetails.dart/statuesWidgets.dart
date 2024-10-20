import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Deliverd extends StatelessWidget {
  const Deliverd({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 188, 218, 172),
          borderRadius: BorderRadius.circular(9)),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(8),
            CircleAvatar(
              backgroundColor: Color.fromARGB(255, 115, 126, 102),
              radius: 4,
            ),
            Gap(4),
            Text(
              "Deliverd",
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
            ),
            Gap(8),
          ],
        ),
      ),
    );
  }
}

class Cancelled extends StatelessWidget {
  const Cancelled({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 241, 174, 140),
          borderRadius: BorderRadius.circular(9)),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(8),
            CircleAvatar(
              backgroundColor: Color.fromARGB(255, 133, 106, 87),
              radius: 4,
            ),
            Gap(4),
            Text(
              "canceled",
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
            ),
            Gap(8),
          ],
        ),
      ),
    );
  }
}

class InProgress extends StatelessWidget {
  const InProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 238, 214, 150),
          borderRadius: BorderRadius.circular(9)),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(8),
            CircleAvatar(
              backgroundColor: Color.fromARGB(255, 135, 109, 84),
              radius: 4,
            ),
            Gap(4),
            Text(
              "in Progress",
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
            ),
            Gap(8),
          ],
        ),
      ),
    );
  }
}
