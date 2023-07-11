extension BoolExtensions on bool {
  T when<T>(T Function() trueFn, T Function() falseFn) {
    return this ? trueFn() : falseFn();
  }
}
