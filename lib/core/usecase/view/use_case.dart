import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/core/response_error/view/response_error.dart';

abstract class UseCase<Type, Params> {
  Future<Either<ResponseError, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
