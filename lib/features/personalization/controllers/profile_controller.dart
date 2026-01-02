import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kkn_store/data/repositories/authentication/authentication_repository.dart';
import 'package:kkn_store/data/repositories/user/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _userRepository = Get.put(UserRepository());
  final _authRepository = Get.put(AuthenticationRepository());

  final userProfile = Rx<Map<String, dynamic>>({});
  String get email => userProfile.value['email'] ?? "";
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
        print('DEBUG: Fetched User Profile: $data');
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

  Future<void> updateProfileField(String field, dynamic value) async {
    try {
      isLoading.value = true;
      await _userRepository.updateUserField(field, value);
      // Refresh data
      await fetchUserProfile();
    } catch (e) {
      Get.snackbar('Error', 'Could not update $field');
    } finally {
      isLoading.value = false;
    }
  }

  /// Upload Profile Picture
  Future<void> uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );
      if (image != null) {
        isLoading.value = true;
        // Upload
        final userId = _authRepository.authUser?.id ?? '';
        final imageExtension = image.path.split('.').last;
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final imageUrl = await _userRepository.uploadImage('users/images/profile/$userId-$timestamp.$imageExtension', image);
        
        // Update user Record
        updateProfileField('avatar_url', imageUrl);
      }
    } catch (e) {
      Get.snackbar('Error', 'Oh Snap! $e');
    } finally {
      isLoading.value = false;
    }
  }
}
