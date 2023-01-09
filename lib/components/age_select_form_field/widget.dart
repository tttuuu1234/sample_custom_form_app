import 'package:flutter/material.dart';

import '../../validator/validator.dart';
import '../input_text_form_field/widget.dart';

/// 年齢選択フィールド
/// Validation可能
class AgeSelectFormField extends FormField<int> {
  AgeSelectFormField({
    super.key,
    required TextEditingController textEditingController,
    // 返却値をnull許可にし、intRequiredのValidatorでの確認を有効にしている
    required Future<int?> Function() showBottomSheet,
  }) : super(
          validator: (value) {
            String? errorMessage;
            final rules = [
              ValidatorControl.intRequired(),
              ValidatorControl.min(),
            ];

            for (final rule in rules) {
              if (rule.validate(value)) {
                errorMessage = rule.getMessage();
                break;
              }
            }

            return errorMessage;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          builder: (state) {
            return GestureDetector(
              onTap: () async {
                final age = await showBottomSheet();
                // 返却値を使用しstateの更新を行うことで、Widget内での値表示の更新、Validatorの発火を行なってくれる
                state.didChange(age);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputTextFormFiled(
                    textEditingController: textEditingController,
                    label: Text(
                      state.value == null ? '年齢を選択してください' : '年齢',
                    ),
                    enabled: false,
                  ),
                  state.hasError
                      ? Text(
                          state.errorText!,
                          style: const TextStyle(color: Colors.red),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            );
          },
        );
}
