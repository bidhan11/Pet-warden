import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/auth/sign_up_controller.dart';
import 'package:petwarden/main.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/validators.dart';
import 'package:petwarden/view/auth/log_in_screen.dart';
import 'package:petwarden/view/auth/sign_up_screen_pet.dart';
import 'package:petwarden/widgets/custom/custom_elevated_button.dart';
import 'package:petwarden/widgets/custom/custom_password_field.dart';
import 'package:petwarden/widgets/custom/custom_text_field.dart';

import '../../widgets/custom/custom_text_styles.dart';

class SignUpPageUser extends StatelessWidget {
  static const routeName = "/signup-user";
  final c = Get.find<SignUpController>();
  SignUpPageUser({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: PetWardenColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: PetWardenColors.backgroundColor,
          elevation: 0,
          surfaceTintColor: PetWardenColors.backgroundColor,
          leading: InkResponse(
            radius: 20,
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 24,
              color: PetWardenColors.buttonColor,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign Up",
                    style: CustomTextStyles.f28W700(color: PetWardenColors.primaryColor),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Enter your credentials for signing to  ',
                      style: CustomTextStyles.f14W600(color: PetWardenColors.highlightTextColor),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Pet Warden',
                            style: CustomTextStyles.f14W600(color: PetWardenColors.buttonColor)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 43,
                  ),
                  Center(
                    child: Stack(alignment: Alignment.bottomRight, children: [
                      GestureDetector(
                          onTap: c.pickImage,
                          child: Obx(
                            () => CircleAvatar(
                              radius: 60,
                              backgroundImage: c.profilePicPath.value == 'http://surl.li/rkdax'
                                  ? NetworkImage(c.profilePicPath.value)
                                  : FileImage(File(c.profilePicPath.value))
                                      as ImageProvider<Object>,
                            ),
                          )),
                      const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.circle,
                              color: Colors.white,
                              size: 28,
                            ),
                            Icon(
                              Icons.circle,
                              color: PetWardenColors.primaryColor,
                              size: 26,
                            ),
                            Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 15,
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
                  const SizedBox(
                    height: 43,
                  ),
                  Form(
                    key: c.signupKeyOwner,
                    child: Column(
                      children: [
                        CustomTextField(
                            hint: "Full name",
                            controller: c.nameController,
                            textInputAction: TextInputAction.next,
                            validator: Validators.checkFieldEmpty,
                            textInputType: TextInputType.text),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomTextField(
                            hint: "Email",
                            controller: c.emailController,
                            textInputAction: TextInputAction.next,
                            validator: Validators.checkEmailField,
                            textInputType: TextInputType.text),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomTextField(
                            hint: "Phone number",
                            controller: c.phoneController,
                            textInputAction: TextInputAction.next,
                            validator: Validators.checkPhoneField,
                            textInputType: TextInputType.text),
                        const SizedBox(
                          height: 25,
                        ),
                        Obx(() => CustomPasswordField(
                            hint: "Password",
                            eye: c.hidePass.value,
                            onEyeClick: c.onEyeClick,
                            controller: c.passwordController,
                            validator: Validators.checkPasswordField,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.none)),
                        const SizedBox(
                          height: 25,
                        ),
                        Obx(() => CustomPasswordField(
                            hint: "Confirm password",
                            eye: c.hideConPass.value,
                            onEyeClick: c.onConEyeClick,
                            controller: c.confirmPasswordController,
                            validator: (value) {
                              if (value != c.passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.none)),
                        const SizedBox(
                          height: 69,
                        ),
                      ],
                    ),
                  ),
                  CustomElevatedButton(
                    onPressed: () {
                      Get.toNamed(SignUpPagePet.routeName);
                    },
                    title: "Next",
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: CustomTextStyles.f14W600(color: PetWardenColors.textColor),
                        children: <TextSpan>[
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.toNamed(LogInScreen.routeName),
                              text: 'Sign In',
                              style: CustomTextStyles.f14W600(color: PetWardenColors.buttonColor)),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
