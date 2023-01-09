import 'package:flutter/material.dart';

import 'components/age_select_form_field/widget.dart';
import 'components/input_text_form_field/widget.dart';
import 'validator/validator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController nicknameController;
  late TextEditingController ageController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  /// 全て入力済みの場合： true
  /// 一つでも未入力の場合： false
  bool isAllInputted = false;

  @override
  void initState() {
    nicknameController = TextEditingController(text: '');
    ageController = TextEditingController(text: '');
    emailController = TextEditingController(text: '');
    passwordController = TextEditingController(text: '');
    super.initState();
  }

  @override
  void dispose() {
    nicknameController.dispose();
    ageController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void setAge(int value) {
    setState(() {
      ageController.value = TextEditingValue(text: value.toString());
    });
  }

  void checkAllInputted() {
    setState(() {
      isAllInputted = nicknameController.text.isNotEmpty &&
          ageController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectableAgeList = List.generate(80, (index) => index);

    return Scaffold(
      appBar: AppBar(
        title: const Text('新規登録'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                InputTextFormFiled(
                  textEditingController: nicknameController,
                  label: const Text('ニックネーム'),
                  hintText: '花田太郎',
                  maxLength: 10,
                  validateRules: [
                    ValidatorControl.required(),
                    ValidatorControl.maxLength(),
                  ],
                  onChanged: (_) {
                    checkAllInputted();
                  },
                ),
                const SizedBox(height: 16),
                AgeSelectFormField(
                  textEditingController: ageController,
                  showBottomSheet: () async {
                    await _showBottomSheet(
                      context: context,
                      selectableAgeList: selectableAgeList,
                      setAge: setAge,
                    );
                    final age = ageController.text.isEmpty
                        ? null
                        : int.parse(ageController.text);
                    checkAllInputted();

                    return age;
                  },
                ),
                const SizedBox(height: 16),
                InputTextFormFiled(
                  textEditingController: emailController,
                  label: const Text('メールアドレス'),
                  hintText: 'xxx@yyy.com',
                  textInputType: TextInputType.emailAddress,
                  validateRules: [
                    ValidatorControl.required(),
                    ValidatorControl.email(),
                  ],
                  onChanged: (_) {
                    checkAllInputted();
                  },
                ),
                const SizedBox(height: 16),
                InputTextFormFiled(
                  textEditingController: passwordController,
                  label: const Text('パスワード'),
                  hintText: '8〜20文字の間で入力してください。',
                  textInputType: TextInputType.emailAddress,
                  maxLength: 20,
                  validateRules: [
                    ValidatorControl.required(),
                    ValidatorControl.between(),
                  ],
                  onChanged: (_) {
                    checkAllInputted();
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: isAllInputted && formKey.currentState!.validate()
                      ? () {
                          print('ボタン活性時の処理');
                        }
                      : null,
                  child: const Text('登録'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 年齢選択ボトムシート表示
Future<void> _showBottomSheet({
  required BuildContext context,
  required List<int> selectableAgeList,
  required void Function(int value) setAge,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('戻る'),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: selectableAgeList.length,
                itemBuilder: (context, index) {
                  final age = selectableAgeList[index];

                  return InkWell(
                    onTap: () {
                      setAge(age);
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          age.toString(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
