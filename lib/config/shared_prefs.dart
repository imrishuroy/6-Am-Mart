import 'package:shared_preferences/shared_preferences.dart';

const String _showIntro = 'showIntro';
const String keyTheme = 'theme';
const String _token = 'token';
const String _firstTime = 'firstTime';
const String _sortType = 'sortType';

const String _skipAd = '_skipAd';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  bool containsKey(String value) {
    return _sharedPrefs != null && _sharedPrefs!.containsKey(value);
  }

  List<String> getCartList(String value) {
    return _sharedPrefs != null ? _sharedPrefs?.getStringList(value) ?? [] : [];
  }

  Future<bool> setCartList(
      {required String value, required List<String> cart}) async {
    return _sharedPrefs != null
        ? await _sharedPrefs!.setStringList(value, cart)
        : false;
  }

  bool get checkPrefsNull =>
      _sharedPrefs != null && _sharedPrefs!.containsKey(keyTheme);

  int get theme => _sharedPrefs?.getInt(keyTheme) ?? 0;

  String? get token => _sharedPrefs?.getString(_token);

  bool get isFirstTime => _sharedPrefs?.getBool(_firstTime) ?? true;

  bool get sortType => _sharedPrefs?.getBool(_firstTime) ?? false;

  bool get skipAd => _sharedPrefs?.getBool(_skipAd) ?? true;

  bool get showIntro => _sharedPrefs?.getBool(_showIntro) ?? true;

  Future<String?> getStringValue({required String key}) async {
    if (_sharedPrefs != null) {
      return _sharedPrefs?.getString(key);
    }
    return null;
  }

  Future<void> setToken(String value) async {
    if (_sharedPrefs != null) {
      await _sharedPrefs?.setString(_token, value);
    }
  }

  Future<void> disableIntro() async {
    if (_sharedPrefs != null) {
      await _sharedPrefs?.setBool(_showIntro, false);
    }
  }

  Future<void> setSkipAd(bool value) async {
    if (_sharedPrefs != null) {
      await _sharedPrefs?.setBool(_skipAd, value);
    }
  }

  Future<void> setSortType(bool value) async {
    if (_sharedPrefs != null) {
      await _sharedPrefs?.setBool(_sortType, value);
    }
  }

  Future<bool> deleteEverything() async {
    print('This runs -7');
    if (_sharedPrefs != null) {
      print('This runs -6');
      final result = await _sharedPrefs?.clear();
      return result ?? false;
    }
    return false;
  }

  Future<void> setStringValue(
      {required String key, required String value}) async {
    if (_sharedPrefs != null) {
      await _sharedPrefs?.setString(key, value);
    }
  }

  Future<void> setFirstTime(bool value) async {
    if (_sharedPrefs != null) {
      await _sharedPrefs?.setBool(_firstTime, value);
    }
  }

  //setTheme
  // We can access this as await SharedPrefs().setTheme(event.theme.index);
  Future<void> setTheme(int value) async {
    if (_sharedPrefs != null) {
      await _sharedPrefs?.setInt(keyTheme, value);
    }
  }
}
