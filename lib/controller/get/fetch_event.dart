import 'package:equatable/equatable.dart';

abstract class FetchEvent extends Equatable {
  const FetchEvent();

  @override
  List<Object?> get props => [];
}

class FetchDataEvent extends FetchEvent {}

class DeleteItemEvent extends FetchEvent {
  final int id;

  const DeleteItemEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class CreateListEvent extends FetchEvent {
  final String email;
  final String description;
  final String title;
  final String imgLink;

  const CreateListEvent({
    required this.email,
    required this.description,
    required this.title,
    required this.imgLink,
  });

  @override
  List<Object?> get props => [email, description, title, imgLink];
}
