part of 'main.dart';

mixin _MyHomePageStateMixin on State<MyHomePage> {
  late final List<Map<String, dynamic>> originExampleData;
  late final ValueNotifier<List<Map<String, dynamic>>> exampleDataSearch;

  @override
  void initState() {
    originExampleData = _generateExampleData();
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
    );
  }
}
