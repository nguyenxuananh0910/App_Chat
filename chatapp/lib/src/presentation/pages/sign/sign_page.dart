import 'package:chatapp/core/utils/helpers/error_empty.dart';
import 'package:chatapp/src/domain/exceptions/extension.dart';
import 'package:chatapp/src/presentation/pages/sign/sign_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignPage extends GetView<SignController> {
  const SignPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 20),
                      child: Column(
                        children: [
                          Text(
                            'Sign Up to!',
                            style: Get.theme.textTheme.headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "To TravelEase Book app.",
                            style: Get.theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(28)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20),
                        child: Form(
                          key: controller.keyForm,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Username',
                                style: Get.theme.textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return value
                                        .checkEmpty(ErrorAndIsEmtys.name);
                                  }
                                  if (controller
                                          .usernameEditController.text.length >
                                      30) {
                                    return ErrorAndIsEmtys.nameError;
                                  }
                                  return null;
                                },
                                controller: controller.usernameEditController,
                                style: context.theme.textTheme.bodyMedium
                                    ?.copyWith(
                                        // color: context.theme.hintColor,
                                        ),
                                decoration: InputDecoration(
                                  alignLabelWithHint: true,
                                  hintText: 'Your Name',
                                  hintStyle: context.theme.textTheme.bodySmall
                                      ?.copyWith(color: Colors.grey[500]),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Full Name',
                                style: Get.theme.textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return value
                                        .checkEmpty(ErrorAndIsEmtys.name);
                                  }
                                  if (controller
                                          .nameEditController.text.length >
                                      30) {
                                    return ErrorAndIsEmtys.nameError;
                                  }
                                  return null;
                                },
                                controller: controller.nameEditController,
                                style: context.theme.textTheme.bodyMedium
                                    ?.copyWith(
                                        // color: context.theme.hintColor,
                                        ),
                                decoration: InputDecoration(
                                  alignLabelWithHint: true,
                                  hintText: 'Your Name',
                                  hintStyle: context.theme.textTheme.bodySmall
                                      ?.copyWith(color: Colors.grey[500]),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Email',
                                style: Get.theme.textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return value
                                        .checkEmpty(ErrorAndIsEmtys.email);
                                  }
                                  if (!controller.emailEditController.text
                                      .contains('@')) {
                                    return ErrorAndIsEmtys.emailWrongFormat;
                                  }
                                  return null;
                                },
                                controller: controller.emailEditController,
                                style: context.theme.textTheme.bodyMedium
                                    ?.copyWith(
                                        // color: context.theme.hintColor,
                                        ),
                                decoration: InputDecoration(
                                  alignLabelWithHint: true,
                                  hintText: 'mail@example.com',
                                  hintStyle: context.theme.textTheme.bodySmall
                                      ?.copyWith(color: Colors.grey[500]),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Password',
                                style: Get.theme.textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Obx(
                                () => TextFormField(
                                  controller: controller.passwordEditController,
                                  obscureText: !controller.showPassword.value,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return value
                                          .checkEmpty(ErrorAndIsEmtys.password);
                                    }
                                    if (controller.passwordEditController.text
                                            .contains(' ') ||
                                        !controller.specialCharsRegex.hasMatch(
                                            controller
                                                .passwordEditController.text
                                                .trim())) {
                                      return ErrorAndIsEmtys.passwordError;
                                    }
                                    return null;
                                  },
                                  style: context.theme.textTheme.bodyMedium
                                      ?.copyWith(
                                          // color: context.theme.hintColor,
                                          ),
                                  decoration: InputDecoration(
                                    // errorText: controller.passwordError.value,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        controller.showPassword.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () => controller
                                          .togglePasswordVisibility(1),
                                    ),
                                    alignLabelWithHint: true,
                                    hintText: 'Enter your password',
                                    hintStyle: context.theme.textTheme.bodySmall
                                        ?.copyWith(color: Colors.grey[500]),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Confirm Password',
                                style: Get.theme.textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Obx(
                                () => TextFormField(
                                  controller:
                                      controller.confirmPasswordEditController,
                                  obscureText:
                                      !controller.showConfirmPassword.value,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return value.checkEmpty(
                                          ErrorAndIsEmtys.confirmPassword);
                                    }
                                    if (controller
                                            .confirmPasswordEditController.text
                                            .trim() !=
                                        controller.passwordEditController.text
                                            .trim()) {
                                      return ErrorAndIsEmtys
                                          .confirmPasswordError;
                                    }
                                    return null;
                                  },
                                  style: context.theme.textTheme.bodyMedium
                                      ?.copyWith(
                                          // color: context.theme.hintColor,
                                          ),
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        controller.showConfirmPassword.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () => controller
                                          .togglePasswordVisibility(2),
                                    ),
                                    alignLabelWithHint: true,
                                    hintText: 'Enter your password',
                                    hintStyle: context.theme.textTheme.bodySmall
                                        ?.copyWith(color: Colors.grey[500]),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: Get.width,
                                child: GestureDetector(
                                  onTap: () => controller.onSend(),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.redAccent),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          'Sign In',
                                          style: Get.theme.textTheme.titleMedium
                                              ?.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey[300]!)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              // Text(
                              //   'Or Login With',
                              //   style: Get.theme.textTheme.bodyMedium,
                              // ),
                              // const SizedBox(
                              //   height: 20,
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Already have account? ",
                                      style: Get.theme.textTheme.bodyMedium),
                                  InkWell(
                                    onTap: () => Get.back(),
                                    child: Text(
                                      "Sign Up ",
                                      style: Get.theme.textTheme.bodyMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.redAccent),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // if (controller.isLoading.isTrue) const LoadingPage()
          ],
        ),
      ),
    );
  }
}
