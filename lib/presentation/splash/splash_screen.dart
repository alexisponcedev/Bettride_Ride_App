import 'splash_controller.dart';
import 'package:taxi_booking/core/app_export.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(
      SplashController(),
    );
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SizedBox(
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                ImageConstant.appIcon,
              ),
            ),
            Text(
              "Version : 1.0",
              style: TextStyle(
                color: AppColors.textBlackColor,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
