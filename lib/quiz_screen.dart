import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({
    super.key,
    required this.stateModel,
  });

  final QuizStateModel stateModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('簡單測驗')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(stateModel.question,
                style: Theme.of(context).textTheme.titleLarge),
            // 顯示選項
            ...stateModel.options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;

              return Row(
                children: [
                  Container(
                    key: ValueKey('number-$index'),
                    width: 32.0,
                    height: 32.0,
                    decoration:
                        BoxDecoration(color: Colors.amberAccent.shade100),
                    child: Text('${index + 1}'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => stateModel.selectAnswer(option.isCorrect),
                    child: Text(option.answer),
                  ),
                ],
              );
            }),
            ValueListenableBuilder(
              valueListenable: stateModel.result,
              builder: (BuildContext context, final result, Widget? child) {
                return Column(
                  children: [
                    // 顯示反饋
                    if (result.message.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Text(
                        result.message,
                        style: TextStyle(
                          color: result.isCorrect ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class QuizStateModel {
  // 問題和答案資料
  final String question = 'Flutter 是哪一年推出的？';
  final List<({String answer, bool isCorrect})> options = [
    (answer: '2015', isCorrect: false),
    (answer: '2017', isCorrect: true),
    (answer: '2019', isCorrect: false),
  ];

  // 用來存儲用戶選擇答案後的反饋
  ValueNotifier<({bool isCorrect, String message})> result =
      ValueNotifier((isCorrect: false, message: ''));

  // 用來處理用戶選擇答案的邏輯
  void selectAnswer(bool isCorrect) {
    if (isCorrect) {
      result.value = (isCorrect: isCorrect, message: '正確！');
    } else {
      result.value = (isCorrect: isCorrect, message: '錯誤，請再試一次。');
    }
  }
}
