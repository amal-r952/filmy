import 'dart:async';

import 'package:filmy/src/bloc/base_bloc.dart';
import 'package:filmy/src/models/get_users_list_response_model.dart';
import 'package:filmy/src/models/state.dart';
import 'package:filmy/src/utils/constants.dart';
import 'package:filmy/src/utils/object_factory.dart';
import 'package:filmy/src/utils/validators.dart';

class UserBloc extends Object with Validators implements BaseBloc {
  /// Stream Controllers
  final StreamController<bool> _loading = StreamController<bool>.broadcast();
  final StreamController<GetUsersListResponseModel> _fetchUsers =
      StreamController<GetUsersListResponseModel>.broadcast();

  /// Streams
  Stream<bool> get loadingListener => _loading.stream;
  Stream<GetUsersListResponseModel> get fetchUsersResponse =>
      _fetchUsers.stream;

  /// Stream Sinks
  StreamSink<bool> get loadingSink => _loading.sink;
  StreamSink<GetUsersListResponseModel> get fetchUsersSink => _fetchUsers.sink;

  /// Functions

  fetchUsers({required int pageNumber}) async {
    State? state =
        await ObjectFactory().repository.fetchUsers(pageNumber: pageNumber);

    if (state is SuccessState) {
      fetchUsersSink.add(state.value);
    } else if (state is ErrorState) {
      fetchUsersSink.addError(Constants.SOME_ERROR_OCCURRED);
    }
  }

  ///disposing the stream if it is not using
  @override
  void dispose() {
    _loading.close();
    _fetchUsers.close();
  }
}
