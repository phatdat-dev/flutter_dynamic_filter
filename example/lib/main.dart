import 'package:flutter/material.dart';
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
    Field(fieldName: 'Name'),
    Field(fieldName: 'Age'),
    Field(fieldName: 'Phone'),
    Field(fieldName: 'Address'),
    Field(fieldName: 'Date of Birth'),
    Field(fieldName: 'Status'),
    Field(fieldName: 'Testttttttttttttttttttttt'),
    ...List.generate(
      13,
      (index) => Field(
        fieldName: 'Field $index',
        fieldType: FieldType.values[index % FieldType.values.length],
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
              width: 100,
              child: SortMenu(
                sortOrders: ValueNotifier({
                  FieldSortOrder(Field(fieldName: 'Name'), OrderBy.ascending),
                  FieldSortOrder(Field(fieldName: 'Age'), OrderBy.descending),
                }),
                fields: fields,
                onChanged: (sortOrders) {
                  Printt.white('Sort Orders: $sortOrders');
                },
              ),
            ),
            SizedBox(
              width: 130,
              child: AdvancedFilterButton(
                advancedFilter: ValueNotifier(null),
                fields: fields,
                onChanged: (shortFilter) {
                  Printt.white('Short Filter: $shortFilter');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
