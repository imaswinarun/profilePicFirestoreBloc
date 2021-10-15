import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profilePiCTask/screens/bloc/FireStoreUpdate/fireStoreUpdate_event.dart';
import 'package:profilePiCTask/screens/bloc/FireStoreUpdate/fireStoreUpdate_state.dart';

class FireStoreUpdateBloc
    extends Bloc<FireStoreUpdateEvent, FireStoreUpdateState> {
  FireStoreUpdateBloc() : super(FireStoreUpdateInitialState());

  @override
  Stream<FireStoreUpdateState> mapEventToState(
      FireStoreUpdateEvent event) async* {
    if (event is FireStoreUpdateInitialUploadEvent) {
      yield FireStoreUpdateUploadingState();
    } else if (event is FireStoreUpdateFinishEvent) {
      yield FireStoreUpdateFinishedState();
    } else if (event is FireStoreUpdateErrorEvent) {
      yield FireStoreUpdateErrorState();
    }
  }
}
