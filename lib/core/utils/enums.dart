enum CachingType {
  simple,
}

enum ThemeFlavor {
  system,
  light,
  dark;

  factory ThemeFlavor.fromString(String? name) {
    if (name == null || name == '') return defaultValue;

    return ThemeFlavor.values.firstWhere(
      (flavor) => flavor.name == name,
      orElse: () => defaultValue,
    );
  }

  static const defaultValue = ThemeFlavor.system;
}

enum GenericStates {
  loading,
  success,
  error,
  initial;

  factory GenericStates.fromString(String? name) {
    if (name == null || name == '') return defaultValue;

    return GenericStates.values.firstWhere(
      (state) => state.name == name,
      orElse: () => defaultValue,
    );
  }

  static const defaultValue = GenericStates.initial;
}

enum InternetState { initialState, onState, offState }
