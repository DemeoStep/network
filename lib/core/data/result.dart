class Result<T> {
  final T? data;
  final Exception? error;

  Result({this.data, this.error});

  Result.ok(T data) : this(data: data, error: null);
  Result.error({required Exception error}) : this(data: null, error: error);

  bool get isOk => data != null && error == null;
  bool get isError => error != null;
}
