import 'package:equatable/equatable.dart';

import '../../model/get_model.dart';

abstract class FetchState extends Equatable {
  const FetchState();

  @override
  List<Object?> get props => [];
}

class FetchInitial extends FetchState {}

class FetchLoading extends FetchState {}

class FetchSuccess extends FetchState {
  final List<GetModel> data;

  const FetchSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class FetchError extends FetchState {
  final String message;

  const FetchError(this.message);

  @override
  List<Object?> get props => [message];
}

class CreateListState extends FetchState {
  const CreateListState();

  @override
  List<Object?> get props => [];
}

class CreateListInitial extends CreateListState {}

class CreateListLoading extends CreateListState {}

class CreateListSuccess extends CreateListState {}

class CreateListError extends CreateListState {
  final String message1;

  const CreateListError(this.message1);

  @override
  List<Object?> get props => [message1];
}
