import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dynamic_filter/flutter_dynamic_filter.dart';

part 'datatable.part.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_dynamic_filter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //https://stackoverflow.com/questions/69232764/flutter-web-cannot-scroll-with-mouse-down-drag-flutter-2-5
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
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

class _MyHomePageState extends State<MyHomePage> with _MyHomePageStateMixin {
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
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: _buildDataTable(),
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
                      final filterEngine = FilterEngine(
                        data: originExampleData,
                        sortOrders: sortOrders,
                      );

                      final result = filterEngine.sortList();
                      exampleDataSearch.value = result;
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

                      final result = filterEngine.filterList();
                      exampleDataSearch.value = result;
                      // Printt.defaultt(json);
                    },
                  ),
                ),
                SizedBox(
                  width: 130,
                  child: ElevatedButton(
                    child: const Text("Apply Filter and Sort"),
                    onPressed: () {
                      final filterEngine = FilterEngine(
                        data: originExampleData,
                        filterGroup: FilterGroup(name: "My Filter", rules: advancedFilter.value),
                        sortOrders: sortOrders.value,
                      );

                      final result = filterEngine.applyFilterAndSort();
                      exampleDataSearch.value = result;
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
                    child: const Text("Generate Data"),
                  ),
                ),
              ].map((e) => Padding(padding: const EdgeInsets.all(2.5), child: e)).toList(),
            ),
          ))
        ],
      ),
    );
  }
}

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
List<Map<String, dynamic>> _generateExampleData() {
  // Tạo danh sách chứa dữ liệu mẫu
  final List<Map<String, dynamic>> exampleDataList = [];
  final random = Random();

  // Một số tên mẫu để sử dụng ngẫu nhiên
  final names = [
    "John",
    "Jane",
    "Alice",
    "Bob",
    "Charlie",
    "Dave",
    "Eva",
    "Frank",
    "Grace",
    "Hank",
    "Ivy",
    "Jack",
    "Kate",
    "Liam",
    "Mia",
    "Noah",
    "Olivia",
    "Peter",
    "Quinn",
    "Ryan",
    "Sara",
    "Tom",
    "Uma",
    "Vince",
    "Wendy",
    "Xander",
    "Yara",
    "Zane",
  ];
  final status = ["Active", "Pending", "Deleted", "Banned", "Draft"];
  final street = ["Main", "First", "Second", "Third", "Fourth", "Park", "Oak", "Pine", "Elm", "Maple"];
  final streetType = ["St", "Ave", "Blvd", "Cir", "Ct", "Dr", "Ln", "Pkwy", "Rd", "St", "Way"];
  final city = ["Anytown", "Otherville", "Someburg", "Everycity", "Nowhere", "Uptown", "Downtown", "Outatown"];

  for (int i = 1; i <= 500; i++) {
    final data = <String, dynamic>{
      "Name": "${names[random.nextInt(names.length)]} ${names[random.nextInt(names.length)]}",
      "Age": random.nextInt(100) + 18, // Tuổi từ 18 đến 117
      "Phone": "${random.nextInt(1000).toString().padLeft(3, '0')}-${random.nextInt(10000).toString().padLeft(4, '0')}",
      "Address":
          "${random.nextInt(1000) + 1} ${street[random.nextInt(street.length)]} ${streetType[random.nextInt(streetType.length)]}, ${city[random.nextInt(city.length)]}",
      "Date": DateTime.now().add(Duration(days: random.nextInt(30) - 15)),
      "Status": status[random.nextInt(status.length)],
    };

    // random null value
    if (random.nextBool()) {
      data[data.keys.elementAt(random.nextInt(fields.length))] = null;
    }

    exampleDataList.add(data);
  }
  return exampleDataList;
}
