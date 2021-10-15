import 'package:equatable/equatable.dart';

class FireStoreUpdateState extends Equatable {
  @override
  List<Object> get props => [];
}


class FireStoreUpdateInitialState extends FireStoreUpdateState {}

class FireStoreUpdateUploadingState extends FireStoreUpdateState {}

class FireStoreUpdateFinishedState extends FireStoreUpdateState {}

class FireStoreUpdateErrorState extends FireStoreUpdateState {}
