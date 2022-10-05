import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_ex_ds/widgets/plug_plan_edit.dart';

class PlugPlan extends StatefulWidget {
  const PlugPlan({Key? key}) : super(key: key);

  @override
  State<PlugPlan> createState() => _PlugPlanState();
}

class _PlugPlanState extends State<PlugPlan> {

  void initState() {
    super.initState();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text("Training plan",
                style: Theme.of(context).textTheme.headline4),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Text(list[index].day),
                      title: Text(list[index].plan),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(context, PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (BuildContext context, _, __) {
                                return PlugPlanEdit(context, list[index]);
                              },
                              transitionsBuilder: (___, Animation<double> animation, ____, Widget child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: RotationTransition(
                                    turns: Tween<double>(begin: 0.9, end: 1.0).animate(animation),
                                    child: child,
                                  ),
                                );
                              }
                          ));
                        },
                        icon: const Icon(Icons.create),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

Future getPlan (DayPlan dayPlan) async {
  final prefs = await SharedPreferences.getInstance();
  return dayPlan.plan = (prefs.getString('plan${dayPlan.day}'))!;
}

class DayPlan {
  final String day;
  DayPlan({required this.day});

  String plan = "";
}


DayPlan dayPlan1 = DayPlan(day: "Monday");
DayPlan dayPlan2 = DayPlan(day: "Tuesday");
DayPlan dayPlan3 = DayPlan(day: "Wednesday");
DayPlan dayPlan4 = DayPlan(day: "Thursday");
DayPlan dayPlan5 = DayPlan(day: "Friday");
DayPlan dayPlan6 = DayPlan(day: "Saturday");
DayPlan dayPlan7 = DayPlan(day: "Sunday");

List<DayPlan> list = <DayPlan>[
  dayPlan1, dayPlan2, dayPlan3, dayPlan4, dayPlan5, dayPlan6, dayPlan7
];
