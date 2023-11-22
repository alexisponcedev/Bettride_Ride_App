import 'package:flutter/material.dart';
import 'package:taxi_booking/core/app_export.dart';
import 'package:taxi_booking/presentation/commonWidgets/app_bar.dart';
import 'package:taxi_booking/presentation/history/componets/list.dart';
import 'package:taxi_booking/presentation/history/componets/map.dart';
import 'package:taxi_booking/presentation/history/history_controller.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({Key? key}) : super(key: key);
  final HistoryController _con = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: appBar(
          text: "history".tr,
          back: false,
          backColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              tabContainer(),
              Expanded(
                  child: _con.selectedTabIndex.value == 0
                      ? Listview()
                      : const MapView()),
            ],
          ),
        ),
      ),
    );
  }

  tabContainer() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            _con.tabs.length,
            (index) => tabButton(_con.tabs[index], index),
          ),
        ),
      );

  tabButton(
    String title,
    int value,
  ) =>
      Expanded(
        child: Obx(
          () => GestureDetector(
            onTap: () => _con.selectedTabIndex.value = value,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: 50,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _con.selectedTabIndex.value == value
                    ? AppColors.appColor
                    : Colors.transparent,
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: _con.selectedTabIndex.value == value
                      ? FontWeight.w600
                      : FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      );
}
