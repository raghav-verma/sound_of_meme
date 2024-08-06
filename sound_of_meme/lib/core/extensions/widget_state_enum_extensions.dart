import '../helpers/helpers.dart';

extension WidgetStateEnumExtensions on WidgetStateEnum {
  bool get isLoading {
    return this == WidgetStateEnum.loading;
  }

  bool get isLoaded {
    return this == WidgetStateEnum.loaded;
  }

  bool get isError {
    return this == WidgetStateEnum.error;
  }

  bool get isIdle {
    return this == WidgetStateEnum.idle;
  }

  bool get isNoData {
    return this == WidgetStateEnum.noData;
  }
}
