import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'base_notifier.dart';

class ServiceResponse<T> {
  late bool status;
  final T? data;
  final String? message;
  final StackTrace? stacktrace;

  ServiceResponse({
    this.data,
    this.message,
    this.stacktrace,
    required this.status,
  });

  NotifierState<T> toNotifierState() {
    return NotifierState<T>(
      status: status ? NotifierStatus.done : NotifierStatus.error,
      message: message,
      data: data,
    );
  }

  AsyncValue<T> toAsyncValue() {
    return status ? AsyncData(data as T) : AsyncError(message!, stacktrace!);
  }
}

ServiceResponse<T> serveData<T>({required T? value, String? message}) {
  return ServiceResponse<T>(
    status: true,
    data: value,
    message: message,
  );
}

ServiceResponse<T> serveError<T>({required String error}) {
  return ServiceResponse<T>(
    status: false,
    message: error,
  );
}

Future<ServiceResponse<T>> serveFuture<T>({
  required Future<T> Function(Fail fail) function,
  String Function(Object e)? handleError,
  String Function(T response)? handleData,
}) async {
  try {
    final T response = await function(_fail);
    String? message;
    if (handleData != null) {
      message = handleData(response);
    }
    return serveData<T>(value: response, message: message);
  } on _ServeException catch (e) {
    return serveError<T>(error: e.message);
  } catch (e) {
    String error = handleError == null ? e.toString() : handleError(e);

    return serveError<T>(error: error);
  }
}

Stream<ServiceResponse<T>> serveStream<T>({
  required Stream<T> Function(Fail fail) function,
  String Function(Object e)? handleError,
  String Function(T response)? handleData,
}) async* {
  try {
    yield* function(_fail).map(
      (response) {
        String? message;
        if (handleData != null) {
          message = handleData(response);
        }
        return serveData<T>(
          value: response,
          message: message,
        );
      },
    );
  } on _ServeException catch (e) {
    yield* Stream.value(serveError<T>(error: e.message));
  } catch (e) {
    String error = handleError == null ? e.toString() : handleError(e);
    yield* Stream.value(serveError<T>(error: error));
  }
}

class _ServeException implements Exception {
  late final String message;
  _ServeException(this.message);
}

typedef Fail = Never Function(String message);

Never _fail(String message) => throw _ServeException(message);

typedef FutureResponse<T> = Future<ServiceResponse<T>>;
typedef StreamResponse<T> = Stream<ServiceResponse<T>>;
