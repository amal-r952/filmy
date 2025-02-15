import 'package:filmy/src/models/get_users_list_response_model.dart';
import 'package:filmy/src/models/state.dart';
import 'package:filmy/src/utils/object_factory.dart';

class UserApiProvider {
  Future<State?> fetchUsers({required int pageNumber}) async {
    final response =
        await ObjectFactory().apiClient.fetchUsers(pageNumber: pageNumber);

    if (response.statusCode == 200) {
      return State<GetUsersListResponseModel>.success(
          GetUsersListResponseModel.fromJson(response.data));
    } else {
      return null;
    }
  }
}
