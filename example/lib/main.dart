import 'dart:math';

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
    Field(name: 'Name'),
    Field(name: 'Age', type: FieldType.Number),
    Field(name: 'Phone', type: FieldType.Text),
    Field(name: 'Address', type: FieldType.Text),
    Field(name: 'Date', type: FieldType.Date),
    Field(name: 'Status', type: FieldType.SingleSelect),
    // Field(name: 'Testttttttttttttttttttttt'),
    // ...List.generate(
    //   13,
    //   (index) => Field(
    //     name: 'Field $index',
    //     type: FieldType.values[index % FieldType.values.length],
    //   ),
    // ),
  ];
  late ValueNotifier<Set<FieldSortOrder>> sortOrders;
  late ValueNotifier<List<FieldAdvancedFilter>> advancedFilter;

  late final List<Map<String, dynamic>> originExampleData = _generateExampleData();
  late final ValueNotifier<List<Map<String, dynamic>>> exampleDataSearch = ValueNotifier(originExampleData);

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
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: ValueListenableBuilder<List<Map<String, dynamic>>>(
                valueListenable: exampleDataSearch,
                builder: (context, data, child) {
                  return ListView(
                    children: [
                      DataTable(
                        columns: [
                          const DataColumn(label: Text("Index")),
                          ...fields.map((e) => DataColumn(label: Text(e.name))),
                        ],
                        rows: data
                            .map((e) => DataRow(
                                  cells: [
                                    DataCell(Text(data.indexOf(e).toString())),
                                    ...fields.map((f) => DataCell(Text(e[f.name].toString()))),
                                  ],
                                ))
                            .toList(),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Expanded(
              child: Center(
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
                      onChanged: (advancedFilter) {
                        // final json = jsonEncode(shortFilter);
                        //
                        final filterEngine = FilterEngine(
                          data: originExampleData,
                          filterGroup: FilterGroup(name: "My Filter", rules: advancedFilter),
                        );

                        final result = filterEngine.applyFilters();
                        exampleDataSearch.value = result;
                        // Printt.defaultt(json);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: ElevatedButton(
                      child: const Text("fromJson"),
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
                            "value": {"relativeTo": "Next", "unit": "Week", "relativeToIndex": 1}
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
                  SizedBox(
                    width: 130,
                    child: ElevatedButton(
                      onPressed: () => exampleDataSearch.value = _generateExampleData(),
                      child: const Text("Reset Data"),
                    ),
                  ),
                ].map((e) => Padding(padding: const EdgeInsets.all(2.5), child: e)).toList()),
          ))
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> _generateExampleData() {
  // Tạo danh sách chứa dữ liệu mẫu
  List<Map<String, dynamic>> exampleDataList = [];
  Random random = Random();

  // Một số tên mẫu để sử dụng ngẫu nhiên
  List<String> names = ["John", "Jane", "Alice", "Bob", "Charlie", "Dave", "Eva", "Frank", "Grace", "Hank"];
  List<String> statuses = ["Active", "Inactive", "Pending", "Suspended"];

  for (int i = 1; i <= 500; i++) {
    exampleDataList.add({
      "Name": names[random.nextInt(names.length)],
      "Age": random.nextInt(100) + 18, // Tuổi từ 18 đến 117
      "Phone": "123456789${random.nextInt(1000).toString().padLeft(3, '0')}",
      "Address": "${random.nextInt(1000)} Main St, Anytown, USA",
      "Date": DateTime.now().add(Duration(days: random.nextInt(30) - 15)),
      "Status": statuses[random.nextInt(statuses.length)],
    });
  }
  return exampleDataList;
}
