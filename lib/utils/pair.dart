class Pair<T, J> {
  Pair(this.first, this.second);

  final T first;
  final J second;

  @override
  String toString() => 'Pair[$first, $second]';
}