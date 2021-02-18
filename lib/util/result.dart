
import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@Freezed()
abstract class Result<T> with _$Result<T>{
  const factory Result.success(T value) = Success<T>;
  const factory Result.loading() = Loading;
  const factory Result.error([String errorMessage]) = ErrorDetails;
}