extension StringExtensions on String {
  String customCutString({int starting = 0, int? ending = 100, String replaceString = ""}) => (ending != null && length >= ending) ? "${substring(starting, ending)}$replaceString" : this;

  String get customCapitalizeFirstLetter => isEmpty ? this : "${this[0].toUpperCase()}${substring(1)}";

  double get customStringToDouble {
    double res = 0;

    try {
      res = double.parse(this);
    } catch (_) {}

    return res;
  }

  bool customSearchMatch(String searchValue) {
    bool r = searchValue.trim().replaceAll(" ", "").toLowerCase().contains(trim().replaceAll(" ", "").toLowerCase());
    return r;
  }
}
