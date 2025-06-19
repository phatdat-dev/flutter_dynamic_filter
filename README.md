# Flutter Dynamic Filter - Comprehensive Example

This comprehensive example demonstrates all features of the Flutter Dynamic Filter package, including:

# [Preview Link](https://phatdat-dev.github.io/flutter_dynamic_filter/) 🔗

<div align="center">
  <img src="https://raw.githubusercontent.com/phatdat-dev/flutter_dynamic_filter/refs/heads/main/assets/readme/advanced_filter_1.png" alt="AdvancedFilter" style="display: inline-block;"/>
  <img src="https://github.com/phatdat-dev/flutter_dynamic_filter/blob/main/assets/readme/sort_1.gif?raw=true" alt="SortMenu" style="display: inline-block;"/>
</div>

### Setup for filter

Create varriable

```dart
final ValueNotifier<Set<FieldSortOrder>> sortOrders = ValueNotifier({});
final ValueNotifier<List<FieldAdvancedFilter>> advancedFilter = ValueNotifier([]);
```

Init example Data

```dart
late final List<Map<String, dynamic>> originExampleData;
late final ValueNotifier<List<Map<String, dynamic>>> exampleDataSearch;

@override
void initState() {
  originExampleData = ExampleData.generateExampleData();
  exampleDataSearch = ValueNotifier(originExampleData);
  super.initState();
}
```

Widget

```dart
// Sort Button
SizedBox(
  width: 130,
  child: SortAnchor.button(
    sortOrders: sortOrders,
    fields: ExampleData.fields,
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
// Filter Button
SizedBox(
  width: 130,
  child: AdvancedFilterAnchor.button(
    advancedFilter: advancedFilter,
    fields: ExampleData.fields,
    onChanged: (advancedFilter) {
      final filterEngine = FilterEngine(
        data: originExampleData,
        filterGroup: FilterGroup(name: "My Filter", rules: advancedFilter),
      );
      final result = filterEngine.filterList();
      exampleDataSearch.value = result;
    },
  ),
),
// Sort & Filter
SizedBox(
  width: 130,
  child: ElevatedButton(
    child: const Text("Apply Filter and Sort"),
    onPressed: () {
      final filterEngine = FilterEngine(
        data: originExampleData,
        filterGroup: FilterGroup(name: "Name of your filter", rules: advancedFilter.value),
        sortOrders: sortOrders.value,
      );
      final result = filterEngine.applyFilterAndSort();
      exampleDataSearch.value = result;
    },
  ),
)
```

# FilterEngine

## Overview

The `FilterEngine` allows you to filter and sort a collection of data based on customizable rules and sort orders. It is designed to handle complex filtering scenarios using logical operators like AND and OR.

## Features

- Flexible filtering of data using multiple rules.
- Logical operators (AND/OR) for combining rules.
- Natural sorting with support for multiple fields and order directions.
- Easy integration with Dart and Flutter projects.

### Data Structure

The data to be filtered and sorted should be a list of maps with keys corresponding to field names. For example:

```dart
final data = [
  {'name': 'Alice', 'age': 25, 'city': 'New York'},
  {'name': 'Bob', 'age': 30, 'city': 'Los Angeles'},
  {'name': 'Charlie', 'age': 22, 'city': 'Chicago'},
];
```

### Define Fields and Filters

#### Define Fields

Fields represent the columns or attributes of your data:

```dart
final nameField = Field(name: 'name');
final ageField = Field(name: 'age', type: FieldType.Number);
```

#### Define Filters

Filters specify conditions for filtering data:

```dart
final ageFilter = FieldAdvancedFilter(
  field: ageField,
  value: 25,
  mustMatch: FilterMustMatch.and,
);

final nameFilter = FieldAdvancedFilter(
  field: nameField,
  value: 'Alice',
  mustMatch: FilterMustMatch.or,
);
```

### Create a Filter Group

Combine multiple filters into a group:

```dart
final filterGroup = FilterGroup(
  name: 'Sample Filter Group',
  rules: [ageFilter, nameFilter],
);
```

### Define Sort Orders

Specify the sorting order for fields:

```dart
final sortOrder = FieldSortOrder(
  field: ageField,
  orderBy: OrderByOperator.ascending,
);
```

### Apply Filters and Sorting

Use the `FilterEngine` to filter and sort your data:

```dart
final engine = FilterEngine(
  data: data,
  filterGroup: filterGroup,
  sortOrders: {sortOrder},
);

final result = engine.applyFilterAndSort();
print(result);
```

## 🚀 Features Demonstrated

### 1. **All Field Types**

- **Text**: Basic text filtering with contains, starts with, etc.
- **Number**: Numeric comparisons (greater than, less than, etc.)
- **Date**: Advanced date filtering with relative dates
- **Checkbox**: Boolean filtering (checked/unchecked)
- **SingleSelect/Status**: Single choice with colors and icons
- **MultiSelect**: Multiple choice filtering
- **User/CreatedBy/LastEditedBy**: User-based filtering
- **Relation**: Reference filtering
- **URL/Email/Phone**: Specialized text fields

### 2. **Advanced Filtering**

- **50+ Operators**: Comprehensive filtering options
- **Nested Groups**: Complex AND/OR logic
- **Current User**: Filter by current user
- **Relative Dates**: "Past week", "Next month", etc.
- **Custom Ranges**: Date ranges, number ranges

### 3. **Multi-level Sorting**

- Sort by multiple fields
- Ascending/Descending order
- Drag-and-drop reordering

### 4. **Generic Type Support**

- Works with any data type
- Type-safe filtering
- Custom value extractors

### 5. **UI Features**

- **Preset Filters**: Quick filter buttons
- **Analytics Dashboard**: Real-time statistics
- **Field Types Reference**: Complete documentation
- **Responsive Design**: Works on all screen sizes

## 📊 Sample Data

The example uses 100 sample project tasks with:

- 6 team members
- 7 status types
- 7 categories
- 10 tags
- 10 skills
- Realistic dates and relationships

## 🎯 Quick Start

1. **Basic Filtering**:

   - Click "Add Filter" button
   - Select field type
   - Choose operator
   - Set value

2. **Sorting**:

   - Click "Sort" button
   - Select fields to sort by
   - Choose ascending/descending

3. **Preset Filters**:

   - Use quick filter chips
   - "My Tasks", "Urgent Tasks", etc.

4. **Analytics**:
   - View real-time statistics
   - Task completion rates
   - Category distribution

## 🔧 Customization

The package is highly customizable:

- Custom field types
- Custom operators
- Custom UI components
- Custom value extractors
- Custom validation

## 📱 Responsive Design

The example works on:

- Desktop (full layout)
- Tablet (adaptive layout)
- Mobile (bottom sheets)

## 🎨 Themes

Supports:

- Light/Dark themes
- Material 3 design
- Custom color schemes
- Accessibility features

This comprehensive example showcases the full power of Flutter Dynamic Filter for building advanced data filtering interfaces!
