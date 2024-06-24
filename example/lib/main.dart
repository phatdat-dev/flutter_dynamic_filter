import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dynamic_filter/flutter_dynamic_filter.dart';
import 'package:flutter_dynamic_filter_example/print.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final fields = [
    Field(name: 'Name'),
    Field(name: 'Age', type: FieldType.Number),
    Field(name: 'Phone', type: FieldType.Text),
    Field(name: 'Address', type: FieldType.Text),
    Field(name: 'Date', type: FieldType.Date),
    Field(name: 'Status', type: FieldType.SingleSelect),
    Field(name: 'Testttttttttttttttttttttt'),
    ...List.generate(
      13,
      (index) => Field(
        name: 'Field $index',
        type: FieldType.values[index % FieldType.values.length],
      ),
    ),
  ];
  late ValueNotifier<Set<FieldSortOrder>> sortOrders;
  late ValueNotifier<List<FieldAdvancedFilter>> advancedFilter;

  @override
  void initState() {
    sortOrders = ValueNotifier({
      ...[0, 1, 4].map((e) => FieldSortOrder(fields[e], OrderByOperator.ascending)),
    });
    advancedFilter = ValueNotifier([
      ...[0, 1, 4].map((e) => FieldAdvancedFilter(field: fields[e])),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 110,
              child: SortMenu(
                sortOrders: sortOrders,
                fields: fields,
                onChanged: (sortOrders) {
                  Printt.defaultt('Sort Orders: $sortOrders');
                },
              ),
            ),
            SizedBox(
              width: 130,
              child: AdvancedFilterButton(
                advancedFilter: advancedFilter,
                fields: fields,
                onChanged: (shortFilter) {
                  final json = jsonEncode(shortFilter);
                  Clipboard.setData(ClipboardData(text: json));
                  Printt.defaultt(json);
                },
              ),
            ),
            SizedBox(
              width: 130,
              child: ElevatedButton(
                child: const Text("test"),
                onPressed: () {
                  final listJson = [
                    {
                      "mustMatch": "and",
                      "field": {"type": "Text", "name": "Name", "value": null},
                      "operatorType": "TextOperator.contains",
                      "value": null
                    },
                    {
                      "mustMatch": "and",
                      "field": {"type": "Number", "name": "Age", "value": null},
                      "operatorType": "NumberOperator.iss",
                      "value": 123
                    },
                    {
                      "mustMatch": "and",
                      "field": {"type": "Date", "name": "Date", "value": null},
                      "operatorType": "DateTimeOperator.isRelativeToToDay",
                      "value": {"relativeTo": "Next", "unit": "Week"}
                    },
                    {
                      "mustMatch": "and",
                      "field": {"type": "Date", "name": "Date", "value": null},
                      "operatorType": "DateTimeOperator.isBefore",
                      "value": {"operator": "yesterday", "value": "2024-06-23T09:25:31.361"}
                    },
                    {
                      "mustMatch": "and",
                      "field": {"type": "Date", "name": "Date", "value": null},
                      "operatorType": "DateTimeOperator.isAfter",
                      "value": {"operator": "oneWeekFromNow", "value": "2024-07-01T09:25:38.827"}
                    },
                    {
                      "mustMatch": "and",
                      "field": {"type": "Date", "name": "Date", "value": null},
                      "operatorType": "DateTimeOperator.isEmpty",
                      "value": null
                    },
                    {
                      "mustMatch": "and",
                      "field": {"type": "Date", "name": "Date", "value": null},
                      "operatorType": "DateTimeOperator.isBetween",
                      "value": {"start": "2024-06-01T00:00:00.000", "end": "2024-06-07T00:00:00.000"}
                    },
                    {
                      "mustMatch": "and",
                      "field": {"type": "Date", "name": "Date", "value": null},
                      "operatorType": "DateTimeOperator.isOnOrAfter",
                      "value": {"operator": "customDate", "value": "2024-06-18T00:00:00.000"}
                    }
                  ];
                  final example = listJson.map((e) => FieldAdvancedFilter.fromJson(e));
                  advancedFilter.value = example.toList();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
