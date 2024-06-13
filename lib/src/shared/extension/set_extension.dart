extension SetExtension<E> on Set<E> {
  /// swap with index
  Set<E> onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex--;
    final newValue = toList();
    newValue.insert(newIndex, newValue.removeAt(oldIndex));
    return newValue.toSet();
  }
}
