import 'package:flutter/material.dart';
import '../widgets/plug_plan.dart';
import '../widgets/plug_stopwatch.dart';

class PlugMaterial extends StatelessWidget {
  const PlugMaterial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Remote Config",
        routes: {
          '/plug': (context) => const Plug(),
          '/plug/stopwatch': (context) => const PlugStopwatch(),
          '/plug/plan': (context) => const Plug(),
        },
        home: const Plug(),
    );
  }
}


class Plug extends StatefulWidget {

  const Plug({Key? key}) : super(key: key);

  @override
  State<Plug> createState() => _PlugState();
}
class _PlugState extends State<Plug> {

  Color buttonColor = Colors.black;
  Color textColor = Colors.white;
  Color activeButtonColor = Colors.white;
  Color activeTextColor = Colors.black;
  Widget childWidget = const PlugPlan();
  String appBarTitle = "Stopwatch";
  @override
  Widget build(BuildContext context) {

    for (int i = 0; i < list.length; i++) {
      getPlan(list[i]);
      setState(() {});
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(appBarTitle),
      ),
      body: Column(
        children: [
          Align(
            widthFactor: double.infinity,
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      appBarTitle = "Training Plan";
                      childWidget = const PlugPlan();
                      setState(() {});},
                    style: ElevatedButton.styleFrom(
                      maximumSize: Size.infinite,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                    ),
                    child: Text(
                      "Training Plan",
                      style: TextStyle(color: textColor),
                    ),

                  ),
                ),
                Expanded(
                  child:
                  ElevatedButton(
                    onPressed: () {
                      appBarTitle = "Stopwatch";
                      childWidget = const PlugStopwatch();
                      setState(() {});},
                    style: ElevatedButton.styleFrom(

                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                    ),
                    child: Text(
                      "Stopwatch",
                      style: TextStyle(color: textColor),
                    ),

                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: childWidget)
        ],
      ),
    );
  }
}

