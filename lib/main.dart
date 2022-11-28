import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProviderScope(child: SamplePage()),
    );
  }
}

class SamplePage extends HookConsumerWidget {
  const SamplePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [
        _animationControllerProvider.overrideWithValue(
            useAnimationController(duration: Duration(minutes: 1))),
      ],
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            LimitedBox(
              maxHeight: 100,
              child: Container(
                color: Colors.red,
                height: 150,
              ),
            ),
            LimitedBox(
              maxHeight: 100,
              child: Container(
                color: Colors.blue,
                height: 100,
              ),
            ),
            const _AnimationWidget(),
            const _Button(),
            const FractionallySizedBox(
              widthFactor: 1,
              child: Text(
                'わーい',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimationWidget extends HookConsumerWidget {
  const _AnimationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationController = ref.read(_animationControllerProvider);
    return AnimatedBuilder(
      animation: animationController,
      builder: (_, __) {
        return Container(
          color: Colors.black,
          child: Transform(
            alignment: Alignment.topRight,
            transform: Matrix4.skewY(animationController.value)
              ..rotateZ(-pi / animationController.value),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: const Color(0xFFE8581C),
              child: const Text('Apartment for rent!'),
            ),
          ),
        );
      },
    );
  }
}

class _Button extends ConsumerWidget {
  const _Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {
        ref.read(_animationControllerProvider).animateTo(12);
        print('ここ');
      },
      child: const Text('押してだめなら引いてみな'),
    );
  }
}

final _animationControllerProvider =
    Provider<AnimationController>((_) => throw UnimplementedError());
