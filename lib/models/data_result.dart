import 'package:flutter/foundation.dart';

class DataResult<T> {
  final bool success;
  final T value;
  final String error;

  DataResult({
    @required this.success,
    this.value,
    this.error,
  });
}