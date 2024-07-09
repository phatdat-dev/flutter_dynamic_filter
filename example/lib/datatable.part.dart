part of 'main.dart';

mixin _MyHomePageDataTableStateMixin on State<MyHomePage> {
  late List<Map<String, dynamic>> originExampleData;
  late final ValueNotifier<List<Map<String, dynamic>>> exampleDataSearch;

  void onLoadComplete(List<Map<String, dynamic>> data) {
    originExampleData = data;
    exampleDataSearch = ValueNotifier(originExampleData);
  }

  Widget _buildDataTable() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: FutureBuilder(
        future: ExampleData.loadExampleData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            onLoadComplete(snapshot.data!);
            return ValueListenableBuilder<List<Map<String, dynamic>>>(
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
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
