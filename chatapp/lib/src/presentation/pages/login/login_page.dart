import 'package:chatapp/core/router/app_router.dart';
import 'package:chatapp/core/utils/helpers/error_empty.dart';
import 'package:chatapp/src/domain/exceptions/extension.dart';
import 'package:chatapp/src/presentation/pages/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 80),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 40),
                  child: Column(
                    children: [
                      Text(
                        'Welcome Back!',
                        style: Get.theme.textTheme.headlineLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "To your favorite Book app.",
                        style: Get.theme.textTheme.bodyLarge,
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
                        vertical: 36.0, horizontal: 20),
                    child: Form(
                      key: controller.keyForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                return value.checkEmpty(ErrorAndIsEmtys.email);
                              }
                              // if (!controller.emailEditController.text
                              //     .contains('@')) {
                              //   return ErrorAndIsEmtys.emailWrongFormat;
                              // }
                              return null;
                            },
                            controller: controller.emailEditController,
                            style: context.theme.textTheme.bodyMedium?.copyWith(
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
                            height: 20,
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
                                    .contains(' ')) {
                                  return ErrorAndIsEmtys.passwordSpace;
                                }
                                return null;
                              },
                              style:
                                  context.theme.textTheme.bodyMedium?.copyWith(
                                      // color: context.theme.hintColor,
                                      ),
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.showPassword.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onPressed:
                                      controller.togglePasswordVisibility,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(''),
                              TextButton(
                                onPressed: () {},
                                // controller.getToForgotPassword(),
                                child: Text(
                                  'Forgot password?',
                                  style: Get.textTheme.bodySmall!
                                      .copyWith(color: Colors.redAccent),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
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
                                      'Login',
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
                const AltLogins(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AltLogins extends StatelessWidget {
  const AltLogins({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey[300]!)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Or Login With',
                style: Get.theme.textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have ann account? ",
                      style: Get.theme.textTheme.bodyMedium),
                  InkWell(
                    onTap: () => Get.toNamed(AppRouter.signPage),
                    child: Text(
                      "Sign Up ",
                      style: Get.theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.redAccent),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
