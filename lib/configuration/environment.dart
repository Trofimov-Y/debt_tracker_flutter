enum Environment {
  development,
  production,
}

var _currentEnvironment = Environment.development;

Environment get currentEnvironment => _currentEnvironment;

set currentEnvironment(Environment value) => _currentEnvironment = value;
