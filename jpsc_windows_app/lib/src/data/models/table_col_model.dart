class ColumnName<T> {
  String name;
  double width;
  T value;

  ColumnName({required this.name, required this.width, required this.value});
}

class ColumnModel {
  final String name;
  double width;

  ColumnModel({
    required this.name,
    required this.width,
  });
}
