import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CountTimeWidget extends StatelessWidget {
  final String checkIn;

  const CountTimeWidget({
    Key? key,
    required this.checkIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime parseDateTime(String dateTimeString) {
      DateFormat format = DateFormat("dd/MM/yy HH:mm");
      return format.parse(dateTimeString);
    }

    DateTime startTime = parseDateTime(checkIn);

    return Positioned(
      top: 20,
      left: 10,
      child: StreamBuilder<int>(
        stream:
            Stream.periodic(const Duration(seconds: 1), (int count) => count),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          Duration duration = DateTime.now().difference(startTime);

          int hours = duration.inHours;
          int minutes = duration.inMinutes.remainder(60);
          int seconds = duration.inSeconds.remainder(60);

          String formattedTime =
              '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

          Color backgroundColor;
          if (minutes < 30) {
            backgroundColor = Colors.blue;
          } else if (minutes < 55) {
            backgroundColor = Colors.amber;
          } else {
            backgroundColor = Colors.green;
          }

          return Container(
            child: FloatingActionButton.extended(
              onPressed: () {},
              label: Text(formattedTime),
              icon: const Icon(Icons.timer),
              backgroundColor: backgroundColor,
            ),
          );
        },
      ),
    );
  }
}
