import 'package:equatable/equatable.dart';

class FireStoreUpdateEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FireStoreUpdateInitialUploadEvent extends FireStoreUpdateEvent {}

class FireStoreUpdateFinishEvent extends FireStoreUpdateEvent {}

class FireStoreUpdateErrorEvent extends FireStoreUpdateEvent {}
