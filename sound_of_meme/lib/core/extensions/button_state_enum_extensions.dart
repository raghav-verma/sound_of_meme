import '../helpers/helpers.dart';

extension ButtonStateEnumExtensions on ButtonStateEnum {
  bool get isLoading {
    return this == ButtonStateEnum.loading;
  }

  bool get isSuccess {
    return this == ButtonStateEnum.success;
  }

  bool get isError {
    return this == ButtonStateEnum.error;
  }

  bool get isIdle {
    return this == ButtonStateEnum.idle;
  }

  bool get isDisabled {
    return this == ButtonStateEnum.disabled;
  }
}
