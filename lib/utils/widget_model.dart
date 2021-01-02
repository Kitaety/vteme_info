import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_app/common/error_handler.dart';

import 'composite_subscription.dart';

abstract class WidgetModel {
  final ErrorHandler errorHandler;

  final _compositeSubscription = CompositeSubscription();

  WidgetModel({
      @required this.errorHandler,
      });

  /// subscribe for interactors
  StreamSubscription subscribe<T>(
      Stream<T> stream,
      void Function(T t) onValue, {
        void Function(dynamic e) onError,
      }) {
    StreamSubscription subscription = stream.listen(onValue, onError: (e) {
      onError?.call(e);
    });

    _compositeSubscription.add(subscription);
    return subscription;
  }

  /// subscribe for interactors with default handle error
  StreamSubscription subscribeHandleError<T>(
      Stream<T> stream,
      void Function(T t) onValue, {
        void Function(dynamic e) onError,
      }) {
    StreamSubscription subscription = stream.listen(onValue, onError: (e) {
      handleError(e);
      onError?.call(e);
    });

    _compositeSubscription.add(subscription);
    return subscription;
  }

  /// Call a future.
  /// Using Rx wrappers with [subscribe] method is preferable.
  void doFuture<T>(
      Future<T> future,
      void Function(T t) onValue, {
        void onError(e),
      }) {
    future.then(onValue).catchError((e) {
      onError?.call(e);
    });
  }

  /// Call a future with default error handling
  void doFutureHandleError<T>(
      Future<T> future,
      Function(T t) onValue, {
        onError(e),
      }) {
    future.then(onValue).catchError((e) {
      handleError(e);
      onError?.call(e);
    });
  }

  /// Close streams of WM
  void dispose() {
    _compositeSubscription.dispose();
  }

  /// standard error handling
  @protected
  void handleError(dynamic e) {
    errorHandler?.handleError(e);
  }
}