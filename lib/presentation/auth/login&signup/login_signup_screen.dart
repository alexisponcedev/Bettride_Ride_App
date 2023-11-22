import 'package:flutter/material.dart';
import 'package:taxi_booking/core/app_export.dart';
import 'package:taxi_booking/presentation/auth/login&signup/login_signup_controller.dart';
import 'package:taxi_booking/presentation/commonWidgets/app_button.dart';
import 'package:taxi_booking/presentation/commonWidgets/app_text_field.dart';

class LoginSignUpScreen extends StatelessWidget {
  LoginSignUpScreen({Key? key}) : super(key: key);
  final LoginSignupController _con = Get.put(LoginSignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      body: LayoutBuilder(builder: (context, constraint) {
        return SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: (constraint.maxHeight -
                      MediaQuery.of(context).viewPadding.top -
                      MediaQuery.of(context).viewPadding.bottom)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Column(
                    children: [
                      SizedBox(height: Get.height * 0.05),
                      Container(
                        height: Get.height * 0.8,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffF4F5FA),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TabBar(
                                    unselectedLabelColor:
                                        const Color(0xff9196B2),
                                    labelColor: const Color(0xff444C6C),
                                    labelStyle: const TextStyle(fontSize: 16),
                                    indicatorColor: AppColors.appColor,
                                    indicatorWeight: 4,
                                    indicatorPadding:
                                        const EdgeInsets.symmetric(
                                      horizontal: 30,
                                    ),
                                    tabs: [
                                      Tab(text: "login".tr),
                                      Tab(text: "signup".tr),
                                    ],
                                    controller: _con.tabController.value,
                                  ),
                                ),
                                Positioned(
                                  bottom: 25,
                                  left: Get.width / 2 - 20,
                                  child: Container(
                                    height: 42,
                                    width: 3,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffC3CDDB)
                                          .withOpacity(.5),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: _con.tabController.value,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 20,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "welcomeback".tr,
                                          style: TextStyle(
                                            color: AppColors.textBlackColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 50),
                                        AppTextField(
                                          hintText: "emailaddress".tr,
                                          prefixIcon: ImageConstant.email,
                                          onChange: (value) {
                                            _con.email.value = value;
                                          },
                                          errorMessage: _con.emailError,
                                        ),
                                        const SizedBox(height: 10),
                                        AppTextField(
                                          hintText: "password".tr,
                                          obsecureText: true,
                                          prefixIcon: ImageConstant.password,
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Image.asset(
                                              ImageConstant.eye,
                                              height: 20,
                                            ),
                                          ),
                                          onChange: (value) {
                                            _con.password.value = value;
                                          },
                                          errorMessage: _con.passwordError,
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Obx(
                                                  () => InkWell(
                                                    onTap: () {
                                                      _con.termsPolicy.value =
                                                          !_con.termsPolicy
                                                              .value;
                                                    },
                                                    child: Image.asset(
                                                      _con.termsPolicy.isTrue
                                                          ? ImageConstant
                                                              .filledCheckBox
                                                          : ImageConstant
                                                              .checkbox,
                                                      height: 20,
                                                      width: 20,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  'rememberme'.tr,
                                                  style: TextStyle(
                                                    color: AppColors
                                                        .textBlackColor,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                  tapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  minimumSize:
                                                      const Size(0, 0)),
                                              onPressed: () {
                                                Get.toNamed(AppRoutes
                                                    .findPasswordOptionScreen);
                                              },
                                              child: Text(
                                                "forgetpassword".tr,
                                                style: const TextStyle(
                                                  color: Color(0xff04B941),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Text("orloginwith".tr),
                                        const SizedBox(height: 30),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            socialButton(
                                                img: ImageConstant.google),
                                            socialButton(
                                              img: ImageConstant.facebook,
                                            ),
                                            socialButton(
                                              img: ImageConstant.apple,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 30),
                                        AppButton(
                                          text: "loginn".tr,
                                          onPressed: () {
                                            _con.login();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 20,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "registerinbyenteringyouraccountdetails"
                                              .tr,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: AppColors.textBlackColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 50),
                                        AppTextField(
                                          onChange: (val) {
                                            _con.fullname.value = val;
                                          },
                                          hintText: "fullname".tr,
                                          prefixIcon: ImageConstant.user,
                                          errorMessage: _con.fullnameError,
                                        ),
                                        const SizedBox(height: 10),
                                        AppTextField(
                                          onChange: (val) {
                                            _con.email.value = val;
                                          },
                                          hintText: "emailaddress".tr,
                                          prefixIcon: ImageConstant.email,
                                          errorMessage: _con.emailError,
                                        ),
                                        const SizedBox(height: 10),
                                        AppTextField(
                                          onChange: (val) {
                                            _con.password.value = val;
                                          },
                                          hintText: "password".tr,
                                          obsecureText: true,
                                          prefixIcon: ImageConstant.password,
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Image.asset(
                                              ImageConstant.eye,
                                              height: 20,
                                            ),
                                          ),
                                          errorMessage: _con.emailError,
                                        ),
                                        const Spacer(),
                                        AppButton(
                                          text: "signup".tr,
                                          onPressed: () {
                                            _con.signUp();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget socialButton({
    Function? onTap,
    required String img,
  }) =>
      GestureDetector(
        onTap: () => onTap!,
        child: Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xffD4D4D4),
            ),
          ),
          child: Image.asset(
            img,
          ),
        ),
      );
}
