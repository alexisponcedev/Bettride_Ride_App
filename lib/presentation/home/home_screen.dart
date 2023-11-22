import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_booking/core/app_export.dart';
import 'package:taxi_booking/presentation/commonWidgets/search_box.dart';
import 'package:taxi_booking/presentation/home/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final HomeController _con = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    _con.markers.add(
      Marker(
        markerId: const MarkerId("marker_id"),
        position: const LatLng(21.215341, 72.8880675),
        onTap: () {},
      ),
    );
    return Obx(
      () => Scaffold(
        appBar: _appbar(),
        extendBodyBehindAppBar: true,
        extendBody: true,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            SizedBox(
              height: Get.height,
              width: Get.width,
              child: _con.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : GoogleMap(
                      onCameraMove: (position) {
                        _con.customInfoWindowController.onCameraMove!();
                      },
                      markers: _con.markers,
                      mapType: _con.currentMapType,
                      onMapCreated: _con.onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          _con.locationData!.latitude!,
                          _con.locationData!.longitude!,
                        ),
                        zoom: 11,
                      ),
                    ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: Get.height / 2.3,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 7,
                      width: 70,
                      decoration: BoxDecoration(
                        color: AppColors.lightBlue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "whereto".tr,
                            style: TextStyle(
                              color: AppColors.textBlackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "customize".tr,
                            style: TextStyle(
                              color: AppColors.textGreyColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                          padding: const EdgeInsets.only(left: 15),
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Obx(
                              () => GestureDetector(
                                onTap: () {
                                  _con.isSelect.value = index;
                                  _con.selectLocation(context);
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(6),
                                  height: Get.height * .16,
                                  width: Get.height * .16,
                                  decoration: BoxDecoration(
                                    color: _con.isSelect.value == index
                                        ? AppColors.appColor
                                        : AppColors.lightBlue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(7),
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: _con.isSelect.value == index
                                              ? Colors.white
                                              : AppColors.appColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Image.asset(
                                            _con.list[index]["image"]),
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        _con.list[index]["title"],
                                        style: TextStyle(
                                          color: AppColors.textBlackColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        _con.list[index]["subtext"],
                                        style: TextStyle(
                                          color: _con.isSelect.value == index
                                              ? Colors.black.withOpacity(.7)
                                              : AppColors.textGreyColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar _appbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      toolbarHeight: 70,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              _con.controller.openDrawer();
            },
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.white,
                  width: 3,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  ImageConstant.profileImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: searchBox(
              hint: "search".tr,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(15),
                child: Image.asset(ImageConstant.search),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
