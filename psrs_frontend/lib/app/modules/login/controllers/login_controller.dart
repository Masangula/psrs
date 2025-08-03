import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psrs_frontend/app/modules/login/providers/login_provider.dart';
import 'package:psrs_frontend/app/routes/app_pages.dart';
import 'package:psrs_frontend/app/services/storage_service.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final loginProvider = LoginProvider();
  var storageService = Get.find<StorageService>();

  var isLoading = false.obs;

  //  @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  @override
  void onClose() {
    passwordController.dispose();
    emailController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    if (formKey.currentState?.validate() ?? false) {
      isLoading.value = true;
      final response = await loginProvider.userLogin(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      isLoading.value = false;

      if (response.success) {
        Get.snackbar('Success', response.message ?? 'Login successful');
        // Save user data to storage
        storageService.token =
            response.data["token"]; // Assuming data contains the token
        storageService.isLoggedIn = true;
        storageService.email = emailController.text.trim();

        Get.offAllNamed(Routes.HOME); // Navigate to home page
      } else {
        Get.snackbar('Error', response.message ?? 'Login failed');
      }
    } else {
      Get.snackbar('Validation Error', 'Please fill in all fields correctly');
    }
  }
}
