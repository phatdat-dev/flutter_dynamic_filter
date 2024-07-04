part of 'main.dart';

mixin _MyHomePageDataTableStateMixin on State<MyHomePage> {
  late final List<Map<String, dynamic>> originExampleData;
  late final ValueNotifier<List<Map<String, dynamic>>> exampleDataSearch;

  @override
  void initState() {
    originExampleData = ExampleData.generateExampleData();
    exampleDataSearch = ValueNotifier(originExampleData);
    super.initState();
  }

  Widget _buildDataTable() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: exampleDataSearch,
        builder: (context, data, child) {
          return ListView(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    const DataColumn(label: Text("Index")),
                    ...ExampleData.fields.map((e) => DataColumn(label: Text(e.name))),
                  ],
                  rows: data
                      .map((e) => DataRow(
                            cells: [
                              DataCell(Text(data.indexOf(e).toString())),
                              ...ExampleData.fields.map((f) => DataCell(Text(e[f.name]?.toString() ?? ""))),
                            ],
                          ))
                      .toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
