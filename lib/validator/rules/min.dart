import '../message.dart';
import '../validator.dart';

/// 最小数値
class MinValidator implements Validator<int?> {
  MinValidator(this.min);

  final int min;

  @override
  String getMessage() => ValidateMessage.min(min);

  @override
  bool validate(value) {
    if (value == null) {
      return false;
    }

    if (value < min) {
      return true;
    }

    return false;
  }
}
