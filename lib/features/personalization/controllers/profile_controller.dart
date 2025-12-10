import 'package:get/get.dart';
import 'package:kkn_store/data/repositories/authentication/authentication_repository.dart';
import 'package:kkn_store/data/repositories/user/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _userRepository = Get.put(UserRepository());
  final _authRepository = Get.put(AuthenticationRepository());

  final userProfile = Rx<Map<String, dynamic>>({});
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;
      final data = await _userRepository.fetchUserDetails();
      if (data != null) {
        userProfile.value = data;
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong while fetching profile.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
  }
}
