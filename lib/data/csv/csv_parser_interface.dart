abstract interface class CsvParser<T> {
  Future<List<T>> parse(String csvString);
}
