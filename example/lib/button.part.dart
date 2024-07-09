part of 'main.dart';

mixin _MyHomePageButtonStateMixin on State<MyHomePage> implements _MyHomePageDataTableStateMixin {
  late ValueNotifier<Set<FieldSortOrder>> sortOrders;
  late ValueNotifier<List<FieldAdvancedFilter>> advancedFilter;

  @override
  void initState() {
    sortOrders = ValueNotifier({
      ...[0, 1, 4].map((e) => FieldSortOrder(ExampleData.fields[e], OrderByOperator.ascending)),
    });
    advancedFilter = ValueNotifier([
      ...[0, 1, 4].map((e) => FieldAdvancedFilter(field: ExampleData.fields[e])),
    ]);
    super.initState();
  }

  void _sortOnchanged(Set<FieldSortOrder> sortOrders) {
    final filterEngine = FilterEngine(
      data: originExampleData,
      sortOrders: sortOrders,
    );

    final result = filterEngine.sortList();
    exampleDataSearch.value = result;
  }

  void _filterOnchanged(List<FieldAdvancedFilter> advancedFilter) {
    final filterEngine = FilterEngine(
      data: originExampleData,
      filterGroup: FilterGroup(name: "My Filter", rules: advancedFilter),
    );

    final result = filterEngine.filterList();
    exampleDataSearch.value = result;
  }

  Widget _buildButton() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("Icon"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SortAnchor(
                sortOrders: sortOrders,
                fields: ExampleData.fields,
                onChanged: _sortOnchanged,
              ),
              AdvancedFilterAnchor(
                advancedFilter: advancedFilter,
                fields: ExampleData.fields,
                onChanged: _filterOnchanged,
              ),
            ],
          ),
          const Text("Button"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 110,
                child: SortAnchor.button(
                  sortOrders: sortOrders,
                  fields: ExampleData.fields,
                  onChanged: _sortOnchanged,
                ),
              ),
              SizedBox(
                width: 130,
                child: AdvancedFilterAnchor.button(
                  advancedFilter: advancedFilter,
                  fields: ExampleData.fields,
                  onChanged: _filterOnchanged,
                ),
              ),
            ],
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
              onPressed: () async {
                final json = List.from(
                        jsonDecode((await rootBundle.loadString('packages/flutter_dynamic_filter/assets/example_data/field_advanced_filter.json'))))
                    .map((e) => Map<String, dynamic>.from(e));
                final example = json.map((e) => FieldAdvancedFilter.fromJson(e));
                advancedFilter.value = example.toList();
              },
            ),
          ),
          SizedBox(
            width: 130,
            child: ElevatedButton(
              onPressed: () => originExampleData = exampleDataSearch.value = ExampleData.generateExampleData(),
              child: const Text("Generate Data"),
            ),
          ),
        ].map((e) => Padding(padding: const EdgeInsets.all(2.5), child: e)).toList(),
      ),
    );
  }
}
