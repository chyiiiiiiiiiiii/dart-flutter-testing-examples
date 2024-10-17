import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test/post_screen.dart';

int add(int a, int b) {
  return a + b;
}

bool isEven(int number) {
  return number % 2 == 0;
}

class Counter {
  final notifier = ValueNotifier<int>(0); // 通知器，在數值更新時通知監聽者

  void increment() => notifier.value++;
  void decrement() => notifier.value--;

  int get value => notifier.value;
}

final counter = Counter();

Future<int> fetchDataFromApi() async {
  return Future.delayed(const Duration(seconds: 3), () => 42);
}

Future<int> processData() async {
  final data = await fetchDataFromApi();

  return data * 2;
}

Future<int> fetchDataWithApiError() async {
  throw Exception('API 錯誤');
}

Future<int> processDataWithError() async {
  final data = await fetchDataWithApiError();

  return data * 2;
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final number = Random().nextInt(100);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('16 + 95 = ${add(16, 95)}'),
            const SizedBox(
              height: 12,
            ),
            if (isEven(number))
              Text('$number is Even.')
            else
              Text('$number is Odd.'),
            const SizedBox(
              height: 20,
            ),
            ValueListenableBuilder<int>(
              valueListenable: counter.notifier,
              builder: (BuildContext context, int value, Widget? child) {
                return Text('Counter value: $value');
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => counter.increment(),
                  child: const Text('increment'),
                ),
                ElevatedButton(
                  onPressed: () => counter.decrement(),
                  child: const Text('decrement'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const PostScreen(),
                ),
              ),
              child: const Text('Go to Post'),
            ),
          ],
        ),
      ),
    );
  }
}
