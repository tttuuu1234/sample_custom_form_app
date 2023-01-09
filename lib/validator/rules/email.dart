import '../message.dart';
import '../validator.dart';

/// メールアドレス
class EmailValidator implements Validator<String?> {
  static const _partten =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  @override
  String getMessage() => ValidateMessage.email;

  @override
  bool validate(value) {
    if (value == null || value.isEmpty) {
      return false;
    }

    if (!RegExp(_partten).hasMatch(value)) {
      return true;
    }

    return false;
  }
}
