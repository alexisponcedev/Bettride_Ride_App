import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:taxi_booking/core/app_export.dart';
import 'package:taxi_booking/presentation/bottomBar/bottombar_controller.dart';
import 'package:taxi_booking/presentation/commonWidgets/app_button.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt isSelect = (-1).obs;
  final BottomBarController controller = Get.find();

  MapType currentMapType = MapType.terrain;

  Completer<GoogleMapController> googlecontroller = Completer();

  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();

  Set<Marker> markers = {};

  void onMapCreated(GoogleMapController controller) {
    googlecontroller.complete(controller);
  }

  List list = [
    {
      "image": ImageConstant.location,
      "title": "newtrip".tr,
      "subtext": "tapforlocation".tr,
    },
    {
      "image": ImageConstant.activehome,
      "title": "home".tr,
      "subtext": "24km, 39 min",
    },
    {
      "image": ImageConstant.work,
      "title": "work".tr,
      "subtext": "14km, 15 min",
    }
  ];

  @override
  void onInit() {
    if (kDebugMode) {
      print('object');
    }
    getLocation();
    super.onInit();
  }

  Location location = Location();
  bool? _serviceEnabled = false;
  LocationData? locationData;
  getLocation() async {
    isLoading.value = true;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }

    PermissionStatus? _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    locationData = await Location().getLocation();
    if (kDebugMode) {
      print(locationData);
    }
    isLoading.value = false;
    if (kDebugMode) {
      print("=======================================");
    }
    if (kDebugMode) {
      print("-=-=-=-=--=-=-=-=-");
      print(locationData!.latitude);
      print(locationData!.longitude);
    }
  }

  void selectLocation(context) async {
    bottomSheet(context);
  }

  Future<dynamic> bottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(25),
            topStart: Radius.circular(25),
          ),
        ),
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(30),
            child: SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 7,
                    width: 70,
                    decoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    "allowyourlocation".tr,
                    style: TextStyle(
                      color: AppColors.textBlackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "wewillneedyourlocationtogiveyoubetterexperience".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textGreyColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AppButton(
                    color: AppColors.lightBlue,
                    text: "notnow".tr,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppButton(
                    text: "oksure".tr,
                    onPressed: () {
                      Get.toNamed(AppRoutes.trackAddressScreen);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}
