abstract class Repository<T> {
  Future<List<T>> getAll();

  Future add(T item);
}
