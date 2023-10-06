import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neumedira_farhan_test/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  RxString errorMessage = ''.obs;
  RxBool hasError = false.obs;
  final TextEditingController usernameController = TextEditingController();

  startChat() {
    if (usernameController.text.trim().isNotEmpty) {
      errorMessage.value = '';
      hasError.value = false;
      Get.offNamed(Routes.home, arguments: {
        'name': usernameController.text,
      });
    } else {
      hasError.value = true;
      errorMessage.value = 'Nama tidak boleh kosong!';
    }
  }
}
