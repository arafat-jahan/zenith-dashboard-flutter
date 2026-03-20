import '../../models/user_model.dart';

abstract class IChatRepository {
  Stream<String> generateResponseStream(UserModel user, String prompt, {String modelName});
}
