import 'dart:async';

import 'package:flutter/material.dart';


class PlugStopwatch extends StatefulWidget {
  const PlugStopwatch({Key? key}) : super(key: key);

  @override
  State<PlugStopwatch> createState() => _PlugStopwatchState();
}

class _PlugStopwatchState extends State<PlugStopwatch> {
  String formatTime(int milliseconds) {
    var secs = milliseconds ~/ 1000;
    var hours = (secs ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (secs % 60).toString().padLeft(2, '0');

    return "$hours:$minutes:$seconds";
  }

  late Timer timer;

  Stopwatch stopwatch = Stopwatch();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child:
          Text("Stopwatch", style: Theme.of(context).textTheme.headline4),
        ),
        Text(
          formatTime(stopwatch.elapsedMilliseconds),
          style: Theme.of(context).textTheme.headline6,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    stopwatch.isRunning
                        ? {stopwatch.stop(), timer.cancel(), setState(() {})}
                        : {
                      stopwatch.start(),
                      timer = Timer.periodic(
                          const Duration(milliseconds: 200), (timer) {
                        setState(() {});
                      })
                    };
                  },
                  child: Text(stopwatch.isRunning ? "Stop" : "Start")),
              SizedBox(
                width: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    stopwatch.reset();
                    setState(() {});
                  },
                  child: const Text("Reset")),
            ],
          ),
        )
      ],
    );
  }
}
