import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psrs_frontend/app/modules/login/controllers/login_controller.dart';
import 'package:psrs_frontend/app/utils/validators.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            color: Colors.white,
          ),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Login', style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.emailController,
                  validator: Validators.validateEmail,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: controller.passwordController,
                  validator: Validators.validateInput,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                Obx(() {
                  return controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: controller.login,
                          child: const Text('Login'),
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
