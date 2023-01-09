/// Validate時のエラーメッセージ
class ValidateMessage {
  ValidateMessage._();

  static String required = '必須入力です。';
  static String max(int value) {
    return '$value文字以内で入力してください。';
  }

  static String min(int value) {
    return '$value文字以上で入力してください。';
  }

  static String between({required int minLength, required int maxLength}) {
    return '$minLength 〜 $maxLengthで入力してください。';
  }

  static String email = 'email形式で入力してください。';
}
