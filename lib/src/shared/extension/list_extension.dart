import 'dart:math';

typedef _Condition = bool Function();

extension ListExtension<E> on List<E> {
  /// Provide access to the generic type at runtime.
  Type get subType => E;

  //from GetX

  /// Add [item] to [List<E>] only if [item] is not null.
  void addNonNull(E item) {
    if (item != null) add(item);
  }

  /// Add [Iterable<E>] to [List<E>] only if [Iterable<E>] is not null.
  // void addAllNonNull(Iterable<E> item) {
  //   if (item != null) addAll(item);
  // }

  /// Add [item] to List<E> only if [condition] is true.
  void addIf(dynamic condition, E item) {
    if (condition is _Condition) condition = condition();
    if (condition is bool && condition) add(item);
  }

  /// Adds [Iterable<E>] to [List<E>] only if [condition] is true.
  void addAllIf(dynamic condition, Iterable<E> items) {
    if (condition is _Condition) condition = condition();
    if (condition is bool && condition) addAll(items);
  }

  /// Replaces all existing items of this list with [item]
  void assign(E item) {
    clear();
    add(item);
  }

  /// Replaces all existing items of this list with [items]
  void assignAll(Iterable<E> items) {
    clear();
    addAll(items);
  }

  E elementOf(E e) => elementAt(indexOf(e));

  //List.separated count,generator,separator
  //input: cout=> 7, generator=> 1 , separator=> 0
  //output: [1,0,1,0,1,0,1]
  static List<T> separated<T>({required int itemCount, required T Function(int index) separatorBuilder, required T Function(int index) itemBuilder}) {
    final List<T> list = [];
    for (int i = 0; i < itemCount; i++) {
      list.add(itemBuilder(i));
      if (i < itemCount - 1) {
        list.add(separatorBuilder(i));
      }
    }
    return list;
  }

  /// swap with index
  void onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex--;
    insert(newIndex, removeAt(oldIndex));
  }

  // random element
  E get randomElement => this[Random().nextInt(length)];
}

extension IterableNullExtension<E> on Iterable<E>? {
  bool get isNotNullAndEmpty => this != null && this!.isNotEmpty;
}
