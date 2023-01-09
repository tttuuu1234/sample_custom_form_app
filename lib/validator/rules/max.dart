import '../message.dart';
import '../validator.dart';

/// 最大文字数
class MaxLengthValidator implements Validator<String?> {
  MaxLengthValidator(this.maxLength);

  final int maxLength;

  @override
  String getMessage() => ValidateMessage.max(maxLength);

  @override
  bool validate(value) {
    if (value == null || value.isEmpty) {
      return false;
    }

    if (value.length > maxLength) {
      return true;
    }

    return false;
  }
}
