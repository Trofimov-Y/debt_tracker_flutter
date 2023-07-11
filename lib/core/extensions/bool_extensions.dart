extension BoolExtensions on bool {
  T when<T>(T Function() trueFn, T Function() falseFn) {
    return this ? trueFn() : falseFn();
  }

  T? whenOrNull<T>(T Function() trueFn) {
    return this ? trueFn() : null;
  }
}
