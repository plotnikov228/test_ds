import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_ex_ds/widgets/plug_plan.dart';

Widget PlugPlanEdit (BuildContext context, DayPlan dayPlan) {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  GlobalKey<FormFieldState> formFieldKey = GlobalKey<FormFieldState>();
  String str ="";
  return Scaffold(
    body: Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Text(dayPlan.day, style: Theme.of(context).textTheme.headline4),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: globalKey,
            child: TextFormField(
              onChanged: (value) => str = value,
              key: formFieldKey,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Edit your plan',
              ),
              minLines: 4,
              maxLines: 20,

              initialValue: dayPlan.plan,
              keyboardType: TextInputType.multiline,

            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                dayPlan.plan = formFieldKey.currentState!.value;
                setPlan(formFieldKey.currentState!.value, dayPlan);
                print(dayPlan.plan);
                Navigator.pushNamed(context,'/plug/plan');
              },
              child: const Text("Edit")),
        ),
      ],
    ),
  );
}

Future setPlan (String str,DayPlan dayPlan) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('plan${dayPlan.day}', str) as String;
}