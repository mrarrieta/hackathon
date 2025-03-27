// Mocks generated by Mockito 5.4.0 from annotations
// in di/test/src/dependencies_utils_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i2;
import 'dart:ui' as _i6;

import 'package:di/di.dart' as _i3;
import 'package:redux/redux.dart' as _i4;
import 'package:flutter/src/widgets/localizations.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeType_0 extends _i1.SmartFake implements Type {
  _FakeType_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFuture_1<T> extends _i1.SmartFake implements _i2.Future<T> {
  _FakeFuture_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [DependenciesDelegate].
///
/// See the documentation for Mockito's code generation for more information.
class MockDependenciesDelegate extends _i1.Mock
    implements _i3.DependenciesDelegate<String> {
  @override
  Set<_i4.Middleware<String>> get middlewares => (super.noSuchMethod(
        Invocation.getter(#middlewares),
        returnValue: <_i4.Middleware<String>>{},
        returnValueForMissingStub: <_i4.Middleware<String>>{},
      ) as Set<_i4.Middleware<String>>);
  @override
  List<Object?> get props => (super.noSuchMethod(
        Invocation.getter(#props),
        returnValue: <Object?>[],
        returnValueForMissingStub: <Object?>[],
      ) as List<Object?>);
  @override
  _i2.Future<void> registerDependencies(_i3.GetIt? getIt) =>
      (super.noSuchMethod(
        Invocation.method(
          #registerDependencies,
          [getIt],
        ),
        returnValue: _i2.Future<void>.value(),
        returnValueForMissingStub: _i2.Future<void>.value(),
      ) as _i2.Future<void>);
}

/// A class which mocks [LocalizationsDelegate].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalizationsDelegate<T> extends _i1.Mock
    implements _i5.LocalizationsDelegate<T> {
  @override
  Type get type => (super.noSuchMethod(
        Invocation.getter(#type),
        returnValue: _FakeType_0(
          this,
          Invocation.getter(#type),
        ),
        returnValueForMissingStub: _FakeType_0(
          this,
          Invocation.getter(#type),
        ),
      ) as Type);
  @override
  bool isSupported(_i6.Locale? locale) => (super.noSuchMethod(
        Invocation.method(
          #isSupported,
          [locale],
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  _i2.Future<T> load(_i6.Locale? locale) => (super.noSuchMethod(
        Invocation.method(
          #load,
          [locale],
        ),
        returnValue: _FakeFuture_1<T>(
          this,
          Invocation.method(
            #load,
            [locale],
          ),
        ),
        returnValueForMissingStub: _FakeFuture_1<T>(
          this,
          Invocation.method(
            #load,
            [locale],
          ),
        ),
      ) as _i2.Future<T>);
  @override
  bool shouldReload(_i5.LocalizationsDelegate<T>? old) => (super.noSuchMethod(
        Invocation.method(
          #shouldReload,
          [old],
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
}
