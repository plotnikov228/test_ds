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

  Color buttonColor1 = Colors.white;
  Color buttonColor2 = Colors.blue;
  Color textColor1 = Colors.blue;
  Color textColor2 = Colors.white;
  Widget childWidget = const PlugPlan();
  String appBarTitle = "Training Plan";
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
        centerTitle: true,
        title: Text(appBarTitle),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                        buttonColor1 = Colors.white;
                        textColor1 = Colors.blue;
                        buttonColor2 = Colors.blue;
                        textColor2 = Colors.white;
                        appBarTitle = "Training Plan";
                        childWidget = const PlugPlan();
                        });},
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(40),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                        ),
                          backgroundColor: buttonColor1
                      ),
                      child: Text(
                        "Training Plan",
                        style: TextStyle(color: textColor1),
                      ),

                    ),
                  ),
                  Expanded(
                    child:
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                        buttonColor2 = Colors.white;
                        textColor2 = Colors.blue;
                        buttonColor1 = Colors.blue;
                        textColor1 = Colors.white;
                        appBarTitle = "Stopwatch";
                        childWidget = const PlugStopwatch();
                        });
                        },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(40),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                        ),
                        backgroundColor: buttonColor2
                      ),
                      child: Text(
                        "Stopwatch",
                        style: TextStyle(color: textColor2),
                      ),

                    ),
                  ),
                ],
              ),

            Expanded(
                child: childWidget)
          ],
        ),
      ),
    );
  }
}

