import 'rules/min.dart';
import 'rules/between.dart';
import 'rules/email.dart';
import 'rules/max.dart';
import 'rules/required.dart';

abstract class Validator<T> {
  /// Validateメッセージ取得
  String getMessage();

  /// validate実行
  /// true: 無効な入力
  /// false: 有効な入力
  bool validate(T value);
}

/// Validator管理
/// Validatorの呼び出しはここから行う
class ValidatorControl {
  ValidatorControl._();

  /// 文字列必須
  static RequiredValidator required() => RequiredValidator();

  /// 数値必須
  static IntRequiredValidator intRequired() => IntRequiredValidator();

  /// 最大文字数
  static MaxLengthValidator maxLength([int maxLength = 10]) =>
      MaxLengthValidator(maxLength);

  /// 最小数値
  static MinValidator min([int min = 0]) => MinValidator(min);

  /// 最小文字数〜最大文字数の間
  static BetweenValidator between({int minLength = 8, int maxLength = 20}) =>
      BetweenValidator(minLength: minLength, maxLength: maxLength);

  /// メールアドレス形式
  static EmailValidator email() => EmailValidator();
}
