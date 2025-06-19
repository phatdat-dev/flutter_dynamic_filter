import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dynamic_filter/flutter_dynamic_filter.dart';

class ComprehensiveExampleApp extends StatelessWidget {
  const ComprehensiveExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dynamic Filter - Comprehensive Example',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch, PointerDeviceKind.stylus, PointerDeviceKind.unknown},
      ),
      home: const ComprehensiveExamplePage(),
    );
  }
}

class ComprehensiveExamplePage extends StatefulWidget {
  const ComprehensiveExamplePage({super.key});

  @override
  State<ComprehensiveExamplePage> createState() => _ComprehensiveExamplePageState();
}

// Enhanced ProjectTask model with all field types
class ProjectTask {
  final String id;
  final String title;
  final String description;
  final int priority; // 1-5
  final double estimatedHours;
  final double actualHours;
  final bool isCompleted;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime dueDate;
  final DateTime? completedAt;
  final DateTime lastModified;
  final SelectOption status;
  final SelectOption category;
  final List<SelectOption> tags;
  final List<SelectOption> skills;
  final User assignedTo;
  final User createdBy;
  final User lastEditedBy;
  final List<String> relatedTasks;
  final String projectUrl;
  final String contactEmail;
  final String contactPhone;

  ProjectTask({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.estimatedHours,
    required this.actualHours,
    required this.isCompleted,
    required this.isArchived,
    required this.createdAt,
    required this.dueDate,
    this.completedAt,
    required this.lastModified,
    required this.status,
    required this.category,
    required this.tags,
    required this.skills,
    required this.assignedTo,
    required this.createdBy,
    required this.lastEditedBy,
    required this.relatedTasks,
    required this.projectUrl,
    required this.contactEmail,
    required this.contactPhone,
  });

  dynamic getValue(String fieldName) {
    switch (fieldName) {
      case 'id':
        return id;
      case 'title':
        return title;
      case 'description':
        return description;
      case 'priority':
        return priority;
      case 'estimatedHours':
        return estimatedHours;
      case 'actualHours':
        return actualHours;
      case 'isCompleted':
        return isCompleted;
      case 'isArchived':
        return isArchived;
      case 'createdAt':
        return createdAt;
      case 'dueDate':
        return dueDate;
      case 'completedAt':
        return completedAt;
      case 'lastModified':
        return lastModified;
      case 'status':
        return status;
      case 'category':
        return category;
      case 'tags':
        return tags;
      case 'skills':
        return skills;
      case 'assignedTo':
        return assignedTo;
      case 'createdBy':
        return createdBy;
      case 'lastEditedBy':
        return lastEditedBy;
      case 'relatedTasks':
        return relatedTasks;
      case 'projectUrl':
        return projectUrl;
      case 'contactEmail':
        return contactEmail;
      case 'contactPhone':
        return contactPhone;
      default:
        return null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'estimatedHours': estimatedHours,
      'actualHours': actualHours,
      'isCompleted': isCompleted,
      'isArchived': isArchived,
      'createdAt': createdAt.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'lastModified': lastModified.toIso8601String(),
      'status': status.toJson(),
      'category': category.toJson(),
      'tags': tags.map((tag) => tag.toJson()).toList(),
      'skills': skills.map((skill) => skill.toJson()).toList(),
      'assignedTo': assignedTo.toJson(),
      'createdBy': createdBy.toJson(),
      'lastEditedBy': lastEditedBy.toJson(),
      'relatedTasks': relatedTasks,
      'projectUrl': projectUrl,
      'contactEmail': contactEmail,
      'contactPhone': contactPhone,
    };
  }
}

class _ComprehensiveExamplePageState extends State<ComprehensiveExamplePage> with TickerProviderStateMixin {
  late List<ProjectTask> originalData;
  late ValueNotifier<List<ProjectTask>> filteredData;
  late ValueNotifier<Set<FieldSortOrder>> sortOrders;
  late ValueNotifier<List<FieldAdvancedFilter>> advancedFilter;

  int _selectedTabIndex = 0;

  // Define all available fields with different types
  final List<Field> fields = [
    Field(name: 'title', type: FieldType.Text),
    Field(name: 'description', type: FieldType.Text),
    Field(name: 'priority', type: FieldType.Number),
    Field(name: 'estimatedHours', type: FieldType.Number),
    Field(name: 'actualHours', type: FieldType.Number),
    Field(name: 'isCompleted', type: FieldType.Checkbox),
    Field(name: 'isArchived', type: FieldType.Checkbox),
    Field(name: 'createdAt', type: FieldType.Date),
    Field(name: 'dueDate', type: FieldType.Date),
    Field(name: 'completedAt', type: FieldType.Date),
    Field(name: 'lastModified', type: FieldType.Date),
    Field(name: 'status', type: FieldType.Status),
    Field(name: 'category', type: FieldType.SingleSelect),
    Field(name: 'tags', type: FieldType.MultiSelect),
    Field(name: 'skills', type: FieldType.MultiSelect),
    Field(name: 'assignedTo', type: FieldType.User),
    Field(name: 'createdBy', type: FieldType.CreatedBy),
    Field(name: 'lastEditedBy', type: FieldType.LastEditedBy),
    Field(name: 'relatedTasks', type: FieldType.Relation),
    Field(name: 'projectUrl', type: FieldType.URL),
    Field(name: 'contactEmail', type: FieldType.Email),
    Field(name: 'contactPhone', type: FieldType.Phone),
  ];

  // Sample data for dropdowns and selections
  late List<User> availableUsers;
  late List<SelectOption> statusOptions;
  late List<SelectOption> categoryOptions;
  late List<SelectOption> tagOptions;
  late List<SelectOption> skillOptions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Dynamic Filter - Comprehensive Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: TabController(length: 4, vsync: this),
          onTap: (index) => setState(() => _selectedTabIndex = index),
          tabs: const [
            Tab(icon: Icon(Icons.table_chart), text: 'Data Table'),
            Tab(icon: Icon(Icons.analytics), text: 'Analytics'),
            Tab(icon: Icon(Icons.settings), text: 'Field Types'),
            Tab(icon: Icon(Icons.info), text: 'About'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Control Panel
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4, offset: const Offset(0, 2))],
            ),
            child: Column(
              children: [
                // Main Controls
                Row(
                  children: [
                    Expanded(
                      child: SortAnchor.button(sortOrders: sortOrders, fields: fields, onChanged: _onSortChanged),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AdvancedFilterAnchor.button(advancedFilter: advancedFilter, fields: fields, onChanged: _onFilterChanged),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: _onApplyFilterAndSort,
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Apply All'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(onPressed: _resetFilters, icon: const Icon(Icons.clear), label: const Text('Reset')),
                  ],
                ),
                const SizedBox(height: 12),
                // Preset Filters
                Row(
                  children: [
                    const Text('Quick Filters: ', style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Wrap(
                        spacing: 8,
                        children: ['My Tasks', 'Urgent Tasks', 'Overdue Tasks', 'High Priority'].map((preset) {
                          return FilterChip(label: Text(preset), onSelected: (selected) => _loadPresetFilter(preset));
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Status Summary
                ValueListenableBuilder<List<ProjectTask>>(
                  valueListenable: filteredData,
                  builder: (context, data, child) {
                    final total = data.length;
                    final completed = data.where((task) => task.isCompleted).length;
                    final inProgress = data.where((task) => task.status.id == 'in_progress').length;
                    final overdue = data.where((task) => !task.isCompleted && task.dueDate.isBefore(DateTime.now())).length;

                    return Row(
                      children: [
                        _buildStatusChip('Total', total, Colors.blue),
                        const SizedBox(width: 8),
                        _buildStatusChip('Completed', completed, Colors.green),
                        const SizedBox(width: 8),
                        _buildStatusChip('In Progress', inProgress, Colors.orange),
                        const SizedBox(width: 8),
                        _buildStatusChip('Overdue', overdue, Colors.red),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          // Content Area
          Expanded(
            child: IndexedStack(
              index: _selectedTabIndex,
              children: [_buildDataTableTab(), _buildAnalyticsTab(), _buildFieldTypesTab(), _buildAboutTab()],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeSampleData();
    originalData = _generateComprehensiveData();
    filteredData = ValueNotifier(originalData);
    sortOrders = ValueNotifier({});
    advancedFilter = ValueNotifier([]);
  }

  Widget _buildAboutTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About Flutter Dynamic Filter', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),

          const Text(
            'Flutter Dynamic Filter is a comprehensive package for creating advanced filtering and sorting interfaces in Flutter applications. It provides Notion-like filtering capabilities with support for multiple data types and complex filter combinations.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),

          Text('Key Features', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),

          ...[
            '✅ Generic Type Support - Works with any data type, not just Map<String, dynamic>',
            '✅ 13 Field Types - Text, Number, Date, Checkbox, Select, User, Relation, etc.',
            '✅ 50+ Operators - Comprehensive filtering options for each field type',
            '✅ Nested Filter Groups - Complex AND/OR logic combinations',
            '✅ Advanced Date Filtering - Relative dates, ranges, and dynamic options',
            '✅ User-based Filtering - Current user, user roles, and assignments',
            '✅ Multi-level Sorting - Sort by multiple fields with custom order',
            '✅ Performance Optimized - Efficient filtering and sorting algorithms',
            '✅ Customizable UI - Fully customizable filter and sort interfaces',
            '✅ Export/Import - Save and load filter configurations',
          ].map(
            (feature) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(feature, style: const TextStyle(fontSize: 14)),
            ),
          ),

          const SizedBox(height: 24),

          Text('Usage Example', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('''// Create a filter engine with your data
final filterEngine = FilterEngine<YourDataType>(
  data: yourDataList,
  valueExtractor: (item, fieldName) => item.getValue(fieldName),
  filterGroup: FilterGroup(
    logic: FilterLogic.and,
    rules: [
      FieldAdvancedFilter(
        field: Field(name: 'status', type: FieldType.Status),
        operatorType: SelectOperator.iss,
        value: SelectOption(id: 'active', name: 'Active'),
      ),
    ],
  ),
  sortOrders: {
    FieldSortOrder(
      Field(name: 'createdAt', type: FieldType.Date),
      OrderByOperator.descending,
    ),
  },
);

// Apply filters and sorting
final results = filterEngine.applyFilterAndSort();''', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
          ),

          const SizedBox(height: 24),

          Text('Sample Data', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),

          Text('This example uses ${originalData.length} sample project tasks with the following fields:', style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 8),

          ...fields.map(
            (field) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text('• ${field.name} (${field.type.name})', style: const TextStyle(fontSize: 12)),
            ),
          ),

          const SizedBox(height: 24),

          Center(
            child: Column(
              children: [
                const Text(
                  'Try different filters and sorting options to see the power of Flutter Dynamic Filter!',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => setState(() => _selectedTabIndex = 0),
                  icon: const Icon(Icons.table_chart),
                  label: const Text('Go to Data Table'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
            ),
            Text(title, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return ValueListenableBuilder<List<ProjectTask>>(
      valueListenable: filteredData,
      builder: (context, data, child) {
        // Calculate analytics
        final totalTasks = data.length;
        final completedTasks = data.where((task) => task.isCompleted).length;
        final inProgressTasks = data.where((task) => task.status.id == 'in_progress').length;
        final overdueTasks = data.where((task) => !task.isCompleted && task.dueDate.isBefore(DateTime.now())).length;

        final totalEstimatedHours = data.fold<double>(0, (sum, task) => sum + task.estimatedHours);
        final totalActualHours = data.fold<double>(0, (sum, task) => sum + task.actualHours);

        // Group by status
        final statusGroups = <String, int>{};
        for (final task in data) {
          statusGroups[task.status.name] = (statusGroups[task.status.name] ?? 0) + 1;
        }

        // Group by category
        final categoryGroups = <String, int>{};
        for (final task in data) {
          categoryGroups[task.category.name] = (categoryGroups[task.category.name] ?? 0) + 1;
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Analytics Dashboard', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 24),

              // Summary Cards
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
                children: [
                  _buildAnalyticsCard('Total Tasks', totalTasks.toString(), Icons.assignment, Colors.blue),
                  _buildAnalyticsCard('Completed', completedTasks.toString(), Icons.check_circle, Colors.green),
                  _buildAnalyticsCard('In Progress', inProgressTasks.toString(), Icons.play_circle, Colors.orange),
                  _buildAnalyticsCard('Overdue', overdueTasks.toString(), Icons.warning, Colors.red),
                ],
              ),

              const SizedBox(height: 32),

              // Hours Summary
              Row(
                children: [
                  Expanded(child: _buildAnalyticsCard('Estimated Hours', totalEstimatedHours.toStringAsFixed(1), Icons.schedule, Colors.purple)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildAnalyticsCard('Actual Hours', totalActualHours.toStringAsFixed(1), Icons.timer, Colors.indigo)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildAnalyticsCard(
                      'Efficiency',
                      totalEstimatedHours > 0 ? '${((totalActualHours / totalEstimatedHours) * 100).toStringAsFixed(1)}%' : 'N/A',
                      Icons.trending_up,
                      totalActualHours <= totalEstimatedHours ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Charts
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildGroupChart('Tasks by Status', statusGroups)),
                  const SizedBox(width: 32),
                  Expanded(child: _buildGroupChart('Tasks by Category', categoryGroups)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDataTableTab() {
    return ValueListenableBuilder<List<ProjectTask>>(
      valueListenable: filteredData,
      builder: (context, data, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 20,
              headingRowColor: WidgetStateProperty.all(Theme.of(context).colorScheme.surfaceContainerHighest),
              columns: const [
                DataColumn(
                  label: Text('Title', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Priority', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Assigned To', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Category', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Due Date', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Tags', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Progress', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
              rows: data.take(50).map((task) {
                // Limit to 50 rows for performance
                return DataRow(
                  color: WidgetStateProperty.resolveWith((states) {
                    if (task.isCompleted) {
                      return Colors.green.withValues(alpha: 0.1);
                    } else if (task.dueDate.isBefore(DateTime.now())) {
                      return Colors.red.withValues(alpha: 0.1);
                    }
                    return null;
                  }),
                  cells: [
                    DataCell(
                      SizedBox(
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              task.title,
                              style: const TextStyle(fontWeight: FontWeight.w500),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              task.description,
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: task.status.color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(task.status.icon, size: 14, color: task.status.color),
                            const SizedBox(width: 4),
                            Text(
                              task.status.name,
                              style: TextStyle(color: task.status.color, fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...List.generate(5, (index) {
                            return Icon(index < task.priority ? Icons.star : Icons.star_border, size: 16, color: Colors.amber);
                          }),
                          const SizedBox(width: 4),
                          Text('${task.priority}'),
                        ],
                      ),
                    ),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            child: Text(task.assignedTo.avatar ?? task.assignedTo.name[0], style: const TextStyle(fontSize: 10, color: Colors.white)),
                          ),
                          const SizedBox(width: 8),
                          Text(task.assignedTo.name),
                        ],
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: task.category.color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(task.category.icon, size: 14, color: task.category.color),
                            const SizedBox(width: 4),
                            Text(task.category.name, style: TextStyle(color: task.category.color, fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                    DataCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            task.dueDate.toString().substring(0, 10),
                            style: TextStyle(color: task.dueDate.isBefore(DateTime.now()) && !task.isCompleted ? Colors.red : null),
                          ),
                          if (task.dueDate.isBefore(DateTime.now()) && !task.isCompleted)
                            Text(
                              'Overdue',
                              style: TextStyle(fontSize: 10, color: Colors.red.shade700, fontWeight: FontWeight.w500),
                            ),
                        ],
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        width: 150,
                        child: Wrap(
                          spacing: 4,
                          runSpacing: 2,
                          children: task.tags.take(3).map((tag) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(color: tag.color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
                              child: Text(tag.name, style: TextStyle(fontSize: 10, color: tag.color)),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                            color: task.isCompleted ? Colors.green : Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text('${task.actualHours.toInt()}/${task.estimatedHours.toInt()}h', style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFieldTypesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Supported Field Types', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          Text('This example demonstrates all supported field types and their operators:', style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 24),

          ...FieldType.values.map((fieldType) {
            final operators = fieldType.operatorType.cast<OperatorType>();
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          fieldType.svgData.path.contains('text')
                              ? Icons.text_fields
                              : fieldType.svgData.path.contains('number')
                              ? Icons.numbers
                              : fieldType.svgData.path.contains('date')
                              ? Icons.calendar_today
                              : fieldType.svgData.path.contains('checkbox')
                              ? Icons.check_box
                              : fieldType.svgData.path.contains('select')
                              ? Icons.list
                              : fieldType.svgData.path.contains('user')
                              ? Icons.person
                              : fieldType.svgData.path.contains('relation')
                              ? Icons.link
                              : Icons.help,
                        ),
                        const SizedBox(width: 8),
                        Text(fieldType.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(_getFieldTypeDescription(fieldType), style: TextStyle(color: Colors.grey.shade600)),
                    const SizedBox(height: 12),
                    Text('Available Operators:', style: const TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: operators.map((operator) {
                        return Chip(
                          label: Text(operator.label, style: const TextStyle(fontSize: 12)),
                          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildGroupChart(String title, Map<String, int> groups) {
    final total = groups.values.fold(0, (sum, count) => sum + count);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...groups.entries.map((entry) {
              final percentage = total > 0 ? (entry.value / total) * 100 : 0;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Text(entry.key)),
                    Expanded(
                      flex: 5,
                      child: LinearProgressIndicator(value: percentage / 100, backgroundColor: Colors.grey.shade300),
                    ),
                    const SizedBox(width: 8),
                    Text('${entry.value} (${percentage.toStringAsFixed(1)}%)'),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String label, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        '$label: $count',
        style: TextStyle(color: color, fontWeight: FontWeight.w500, fontSize: 12),
      ),
    );
  }

  List<ProjectTask> _generateComprehensiveData() {
    final random = Random();
    final tasks = <ProjectTask>[];

    final taskTitles = [
      'Implement user authentication',
      'Design dashboard UI',
      'Setup CI/CD pipeline',
      'Write API documentation',
      'Fix login bug',
      'Optimize database queries',
      'Create mobile app',
      'Setup monitoring',
      'Implement search feature',
      'Design user onboarding',
      'Setup testing framework',
      'Implement payment system',
      'Create admin panel',
      'Setup error tracking',
      'Implement notifications',
      'Design landing page',
      'Setup backup system',
      'Implement chat feature',
      'Create reporting dashboard',
      'Setup security audit',
    ];

    final descriptions = [
      'Detailed implementation of secure user authentication system',
      'Create intuitive and responsive dashboard interface',
      'Automate deployment process with proper testing',
      'Comprehensive API documentation for developers',
      'Fix critical bug in user login flow',
      'Improve database performance and query optimization',
      'Develop cross-platform mobile application',
      'Setup comprehensive system monitoring',
      'Implement advanced search with filters',
      'Design smooth user onboarding experience',
      'Setup automated testing infrastructure',
      'Integrate secure payment processing',
      'Create comprehensive admin management panel',
      'Setup real-time error tracking and alerts',
      'Implement push and email notifications',
      'Design compelling landing page',
      'Setup automated backup and recovery',
      'Implement real-time chat functionality',
      'Create detailed analytics and reporting',
      'Conduct comprehensive security assessment',
    ];

    for (int i = 0; i < 100; i++) {
      final createdDate = DateTime.now().subtract(Duration(days: random.nextInt(365)));
      final dueDate = createdDate.add(Duration(days: random.nextInt(60) + 1));
      final isCompleted = random.nextBool();
      final completedDate = isCompleted
          ? createdDate.add(Duration(days: random.nextInt((dueDate.difference(createdDate).inDays + 10).clamp(1, 100))))
          : null;

      // Generate related task IDs
      final relatedTaskIds = <String>[];
      final numRelated = random.nextInt(4);
      for (int j = 0; j < numRelated; j++) {
        relatedTaskIds.add('task_${random.nextInt(100)}');
      }

      // Generate random tags (1-4 tags per task)
      final taskTags = <SelectOption>[];
      final numTags = random.nextInt(4) + 1;
      final shuffledTags = List.from(tagOptions)..shuffle();
      for (int j = 0; j < numTags; j++) {
        taskTags.add(shuffledTags[j]);
      }

      // Generate random skills (1-3 skills per task)
      final taskSkills = <SelectOption>[];
      final numSkills = random.nextInt(3) + 1;
      final shuffledSkills = List.from(skillOptions)..shuffle();
      for (int j = 0; j < numSkills; j++) {
        taskSkills.add(shuffledSkills[j]);
      }

      tasks.add(
        ProjectTask(
          id: 'task_$i',
          title: taskTitles[i % taskTitles.length],
          description: descriptions[i % descriptions.length],
          priority: random.nextInt(5) + 1, // 1-5
          estimatedHours: (random.nextInt(40) + 1).toDouble(), // 1-40 hours
          actualHours: isCompleted ? (random.nextInt(50) + 1).toDouble() : 0,
          isCompleted: isCompleted,
          isArchived: random.nextInt(10) == 0, // 10% chance of being archived
          createdAt: createdDate,
          dueDate: dueDate,
          completedAt: completedDate,
          lastModified: DateTime.now().subtract(Duration(days: random.nextInt(30))),
          status: statusOptions[random.nextInt(statusOptions.length)],
          category: categoryOptions[random.nextInt(categoryOptions.length)],
          tags: taskTags,
          skills: taskSkills,
          assignedTo: availableUsers[random.nextInt(availableUsers.length)],
          createdBy: availableUsers[random.nextInt(availableUsers.length)],
          lastEditedBy: availableUsers[random.nextInt(availableUsers.length)],
          relatedTasks: relatedTaskIds,
          projectUrl: 'https://project${i % 10}.company.com',
          contactEmail: 'project${i % 10}@company.com',
          contactPhone: '+1-555-${(1000 + random.nextInt(9000)).toString()}',
        ),
      );
    }

    return tasks;
  }

  String _getFieldTypeDescription(FieldType fieldType) {
    switch (fieldType) {
      case FieldType.Text:
        return 'Basic text input with string operations like contains, starts with, etc.';
      case FieldType.Number:
        return 'Numeric values with mathematical comparisons (greater than, less than, etc.)';
      case FieldType.Date:
        return 'Date and time values with relative and absolute date filtering';
      case FieldType.Checkbox:
        return 'Boolean values (true/false) for binary states';
      case FieldType.SingleSelect:
        return 'Single choice from predefined options';
      case FieldType.MultiSelect:
        return 'Multiple choices from predefined options';
      case FieldType.Status:
        return 'Enhanced single select with colors and icons for status tracking';
      case FieldType.User:
        return 'User references with support for current user filtering';
      case FieldType.CreatedBy:
        return 'User who created the record';
      case FieldType.LastEditedBy:
        return 'User who last modified the record';
      case FieldType.Relation:
        return 'References to other records or entities';
      case FieldType.URL:
        return 'Web URLs with text-based filtering';
      case FieldType.Email:
        return 'Email addresses with text-based filtering';
      case FieldType.Phone:
        return 'Phone numbers with text-based filtering';
    }
  }

  void _initializeSampleData() {
    // Initialize users
    availableUsers = [
      User(id: '1', name: 'John Doe', email: 'john@company.com', isCurrentUser: true, avatar: '👨‍💻'),
      User(id: '2', name: 'Jane Smith', email: 'jane@company.com', avatar: '👩‍💼'),
      User(id: '3', name: 'Bob Johnson', email: 'bob@company.com', avatar: '👨‍🎨'),
      User(id: '4', name: 'Alice Brown', email: 'alice@company.com', avatar: '👩‍🔬'),
      User(id: '5', name: 'Charlie Wilson', email: 'charlie@company.com', avatar: '👨‍🚀'),
      User(id: '6', name: 'Diana Prince', email: 'diana@company.com', avatar: '👩‍⚖️'),
    ];

    // Initialize status options
    statusOptions = [
      SelectOption(id: 'todo', name: 'To Do', color: Colors.grey, icon: Icons.radio_button_unchecked),
      SelectOption(id: 'in_progress', name: 'In Progress', color: Colors.blue, icon: Icons.play_circle),
      SelectOption(id: 'review', name: 'In Review', color: Colors.orange, icon: Icons.rate_review),
      SelectOption(id: 'testing', name: 'Testing', color: Colors.purple, icon: Icons.bug_report),
      SelectOption(id: 'done', name: 'Done', color: Colors.green, icon: Icons.check_circle),
      SelectOption(id: 'blocked', name: 'Blocked', color: Colors.red, icon: Icons.block),
      SelectOption(id: 'cancelled', name: 'Cancelled', color: Colors.grey.shade600, icon: Icons.cancel),
    ];

    // Initialize category options
    categoryOptions = [
      SelectOption(id: 'frontend', name: 'Frontend', color: Colors.cyan, icon: Icons.web),
      SelectOption(id: 'backend', name: 'Backend', color: Colors.indigo, icon: Icons.storage),
      SelectOption(id: 'mobile', name: 'Mobile', color: Colors.green, icon: Icons.phone_android),
      SelectOption(id: 'design', name: 'Design', color: Colors.pink, icon: Icons.palette),
      SelectOption(id: 'testing', name: 'Testing', color: Colors.orange, icon: Icons.bug_report),
      SelectOption(id: 'devops', name: 'DevOps', color: Colors.brown, icon: Icons.cloud),
      SelectOption(id: 'research', name: 'Research', color: Colors.deepPurple, icon: Icons.science),
    ];

    // Initialize tag options
    tagOptions = [
      SelectOption(id: 'urgent', name: 'Urgent', color: Colors.red),
      SelectOption(id: 'important', name: 'Important', color: Colors.orange),
      SelectOption(id: 'bug', name: 'Bug', color: Colors.red.shade300),
      SelectOption(id: 'feature', name: 'Feature', color: Colors.blue),
      SelectOption(id: 'enhancement', name: 'Enhancement', color: Colors.green),
      SelectOption(id: 'documentation', name: 'Documentation', color: Colors.grey),
      SelectOption(id: 'security', name: 'Security', color: Colors.red.shade800),
      SelectOption(id: 'performance', name: 'Performance', color: Colors.yellow.shade700),
      SelectOption(id: 'ui_ux', name: 'UI/UX', color: Colors.purple),
      SelectOption(id: 'api', name: 'API', color: Colors.teal),
    ];

    // Initialize skill options
    skillOptions = [
      SelectOption(id: 'flutter', name: 'Flutter', color: Colors.blue),
      SelectOption(id: 'react', name: 'React', color: Colors.cyan),
      SelectOption(id: 'nodejs', name: 'Node.js', color: Colors.green),
      SelectOption(id: 'python', name: 'Python', color: Colors.yellow.shade700),
      SelectOption(id: 'java', name: 'Java', color: Colors.orange),
      SelectOption(id: 'swift', name: 'Swift', color: Colors.orange.shade800),
      SelectOption(id: 'kotlin', name: 'Kotlin', color: Colors.purple),
      SelectOption(id: 'typescript', name: 'TypeScript', color: Colors.blue.shade800),
      SelectOption(id: 'docker', name: 'Docker', color: Colors.blue.shade600),
      SelectOption(id: 'aws', name: 'AWS', color: Colors.orange.shade600),
    ];
  }

  void _loadPresetFilter(String presetName) {
    switch (presetName) {
      case 'My Tasks':
        advancedFilter.value = [
          FieldAdvancedFilter(
            field: Field(name: 'assignedTo', type: FieldType.User),
          ),
          FieldAdvancedFilter(
            field: Field(name: 'isCompleted', type: FieldType.Checkbox),
          ),
        ];
        break;
      case 'Urgent Tasks':
        advancedFilter.value = [
          FieldAdvancedFilter(
            field: Field(name: 'tags', type: FieldType.MultiSelect),

            value: tagOptions.firstWhere((tag) => tag.id == 'urgent'),
          ),
          FieldAdvancedFilter(
            field: Field(name: 'isCompleted', type: FieldType.Checkbox),
          ),
        ];
        break;
      case 'Overdue Tasks':
        advancedFilter.value = [
          FieldAdvancedFilter(
            field: Field(name: 'dueDate', type: FieldType.Date),
          ),
          FieldAdvancedFilter(
            field: Field(name: 'isCompleted', type: FieldType.Checkbox),
          ),
        ];
        break;
      case 'High Priority':
        advancedFilter.value = [
          FieldAdvancedFilter(
            field: Field(name: 'priority', type: FieldType.Number),

            value: 4,
          ),
        ];
        break;
    }
    _onFilterChanged(advancedFilter.value);
  }

  void _onApplyFilterAndSort() {
    final filterEngine = FilterEngine<ProjectTask>(
      data: originalData,
      valueExtractor: (task, fieldName) => task.getValue(fieldName),
      filterGroup: FilterGroup(rules: advancedFilter.value),
      sortOrders: sortOrders.value,
    );
    filteredData.value = filterEngine.applyFilterAndSort();
  }

  void _onFilterChanged(List<FieldAdvancedFilter> filters) {
    final filterEngine = FilterEngine<ProjectTask>(
      data: originalData,
      valueExtractor: (task, fieldName) => task.getValue(fieldName),
      filterGroup: FilterGroup(rules: filters),
    );
    filteredData.value = filterEngine.filterList();
  }

  void _onSortChanged(Set<FieldSortOrder> orders) {
    final filterEngine = FilterEngine<ProjectTask>(
      data: originalData,
      valueExtractor: (task, fieldName) => task.getValue(fieldName),
      sortOrders: orders,
    );
    filteredData.value = filterEngine.sortList();
  }

  void _resetFilters() {
    setState(() {
      sortOrders.value = {};
      advancedFilter.value = [];
      filteredData.value = originalData;
    });
  }
}
