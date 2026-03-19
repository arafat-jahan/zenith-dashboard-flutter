import '../../models/user_model.dart';

abstract class IChatRepository {
  Future<String> generateResponse(UserModel user, String prompt);
}
