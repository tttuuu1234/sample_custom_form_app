import '../message.dart';
import '../validator.dart';

/// 最小文字数と最大文字数の間
class BetweenValidator implements Validator<String?> {
  BetweenValidator({required this.minLength, required this.maxLength})
      : assert(minLength < maxLength);

  final int minLength;
  final int maxLength;

  @override
  String getMessage() => ValidateMessage.between(
        minLength: minLength,
        maxLength: maxLength,
      );

  @override
  bool validate(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }

    if (minLength > value.length && value.length < maxLength) {
      return true;
    }

    return false;
  }
}
