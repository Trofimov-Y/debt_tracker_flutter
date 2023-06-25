import 'package:debt_tracker/data/storage/shared_preferences_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_keys.dart';

@Injectable(as: SharedPreferencesProvider)
final class SharedPreferencesProviderImpl implements SharedPreferencesProvider {
  const SharedPreferencesProviderImpl(
    this._sharedPreferences,
  );

  final SharedPreferences _sharedPreferences;

  @override
  Future<void> clear() => _sharedPreferences.clear();
}
