extension ListExtensions<E> on List<E> {
  List<E> removeAll(Iterable<E> allToRemove) {
    for (final value in allToRemove) {
      remove(value);
    }
    return this;
  }

  List<E> get duplicates {
    final dupes = List<E>.from(this);
    dupes.removeAll(toSet().toList());
    return dupes;
  }
}
