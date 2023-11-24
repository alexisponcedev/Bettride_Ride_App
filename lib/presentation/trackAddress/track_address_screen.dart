import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_booking/core/app_export.dart';
import 'package:taxi_booking/presentation/commonWidgets/header_container.dart';
import 'package:taxi_booking/presentation/trackAddress/track_address_controller.dart';

class TrackAddressScreen extends StatelessWidget {
  TrackAddressScreen({Key? key}) : super(key: key);
  final TrackAddressController _con = Get.put(TrackAddressController());

  @override
  Widget build(BuildContext context) {
    _con.markers.add(
      Marker(
        markerId: const MarkerId("marker_id"),
        position: const LatLng(22.307159, 73.181221),
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
                          zoom: 11),
                    ),
            ),
            Positioned(
              bottom: 150,
              right: 0,
              left: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    headerContainer(),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Center(
                          child: Image.asset(
                            ImageConstant.distance,
                            height: 100,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "whereareyou".tr,
                                    style: TextStyle(
                                      color: AppColors.textGreyColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "Studio 08 Jake Stream",
                                    style: TextStyle(
                                      color: AppColors.textBlackColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Expanded(
                                    child: DottedLine(
                                      direction: Axis.horizontal,
                                      lineLength: double.infinity,
                                      lineThickness: 1.0,
                                      dashLength: 6.0,
                                      dashColor: Color(0xffE0E4F5),
                                      dashRadius: 0.0,
                                      dashGapLength: 3.0,
                                      dashGapColor: Colors.transparent,
                                      dashGapRadius: 0.0,
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: AppColors.lightBlue,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Image.asset(
                                        ImageConstant.floatingicon,
                                        color: AppColors.appIconColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "pickoff".tr,
                                    style: TextStyle(
                                      color: AppColors.textGreyColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                          AppRoutes.selectAddressScreen);
                                    },
                                    child: Text(
                                      "whereyouwanttogo".tr,
                                      style: TextStyle(
                                        color: AppColors.textBlackColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
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
            onTap: () {},
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
            child: Container(
              padding: const EdgeInsets.only(left: 15),
              height: 55,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff707070).withOpacity(.2),
                      blurRadius: 10,
                    ),
                  ]),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Image.asset(ImageConstant.search),
                  ),
                  hintText: "search".tr,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
