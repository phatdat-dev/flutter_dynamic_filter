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
                sortOrders: ValueNotifier({
                  ...[0, 1, 4].map((e) => FieldSortOrder(fields[e], OrderByOperator.ascending)),
                }),
                fields: fields,
                onChanged: (sortOrders) {
                  Printt.defaultt('Sort Orders: $sortOrders');
                },
              ),
            ),
            SizedBox(
              width: 130,
              child: AdvancedFilterButton(
                advancedFilter: ValueNotifier([
                  ...[0, 1, 4].map((e) => FieldAdvancedFilter(field: fields[e])),
                ]),
                fields: fields,
                onChanged: (shortFilter) {
                  final json = jsonEncode(shortFilter);
                  Clipboard.setData(ClipboardData(text: json));
                  Printt.defaultt(json);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
