import '../message.dart';
import '../validator.dart';

/// 文字必須
class RequiredValidator implements Validator<String?> {
  @override
  String getMessage() => ValidateMessage.required;

  @override
  bool validate(value) {
    if (value == null || value.isEmpty) {
      return true;
    }

    return false;
  }
}

/// 数値必須
class IntRequiredValidator implements Validator<int?> {
  @override
  String getMessage() => ValidateMessage.required;

  @override
  bool validate(int? value) {
    if (value == null) {
      return true;
    }

    return false;
  }
}
