import 'package:flutter/material.dart';
import 'package:patrol/src/extensions.dart';
// ignore: depend_on_referenced_packages
import 'package:test_api/src/backend/invoker.dart';

import 'common.dart';

String get currentTest => Invoker.current!.fullCurrentTestName();

void _print(String text) => print('PATROL_DEBUG: $text');

void main() {
  patrolSetUp(() async {
    _print('setting up before $currentTest');
  });

  patrolTearDown(() async {
    _print('tearing down after $currentTest');
  });

  group('groupA', () {
    patrolSetUp(() async {
      _print('setting up before $currentTest');
    });

    patrolTearDown(() async {
      _print('tearing down after $currentTest');
    });

    patrolTest('testA', nativeAutomation: true, _body);
    patrolTest('testB', nativeAutomation: true, _body);
    patrolTest('testC', nativeAutomation: true, _body);
  });
}

Future<void> _body(PatrolTester $) async {
  final testName = Invoker.current!.fullCurrentTestName();
  _print('test body: name=$testName');

  await createApp($);

  await $(FloatingActionButton).tap();
  expect($(#counterText).text, '1');

  await $(#textField).enterText(testName);

  await $.pumpAndSettle(duration: Duration(seconds: 2));
}
