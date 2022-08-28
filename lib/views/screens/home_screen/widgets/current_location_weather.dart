import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/core/helpers/assets_paths.dart';
import 'package:weather_app/core/theme/colors.dart';
import 'package:weather_app/controllers/home_controller.dart';

class CurrentLocationWeatherWidget extends StatelessWidget {
 const CurrentLocationWeatherWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.40,
            decoration: BoxDecoration(
              image: const DecorationImage(
                colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
                image: AssetImage(
                  AssetsManager.cloudyBackground,
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5.w),
                bottomRight: Radius.circular(5.w),
              ),
            ),
          ),

          Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.40,
            width: MediaQuery
                .of(context)
                .size
                .width,
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            margin: EdgeInsets.only(
              top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.15,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 8.h,
                  child: TextField(
                    style: const TextStyle(
                      color: AppColors.whiteColor,
                    ),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (city) {
                      controller.updateWeather(city);
                    },
                    decoration: InputDecoration(
                      suffix: const Icon(
                        Icons.search,
                        color: AppColors.whiteColor,
                      ),
                      hintStyle: const TextStyle(color: AppColors.whiteColor),
                      hintText: 'Search'.toUpperCase(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.h),
                        borderSide: const BorderSide(
                            color: AppColors.whiteColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.h),
                        borderSide: const BorderSide(
                            color: AppColors.whiteColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.h),
                        borderSide: const BorderSide(
                            color: AppColors.whiteColor),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h,),
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.30,
                  child: Card(
                    color: AppColors.whiteColor,
                    elevation: 1.w,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.w),
                    ),
                    child: controller.isLoading
                        ? const Center(
                      child: SpinKitFadingCircle(
                        color: AppColors.primaryColor,
                        size: 50.0,
                      ),
                    )
                        : Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              '${controller.currentWeatherData!.name}'
                                  .toUpperCase(),
                              style:
                              Theme
                                  .of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                color: AppColors.headersBlackColor,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              DateFormat()
                                  .add_MMMMEEEEd()
                                  .format(DateTime.now()),
                              style:
                              Theme
                                  .of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                color: AppColors.headersBlackColor,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    controller.currentWeatherData!.weather![0]
                                        .description!
                                        .toUpperCase(),
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                      color: AppColors.headersBlackColor,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  Text(
                                    '${(controller.currentWeatherData!.main!
                                        .temp)!.round().toString()}\u2103',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(
                                      color: AppColors.headersBlackColor,
                                    ),
                                  ),
                                  Text(
                                    'Min: ${(controller.currentWeatherData!
                                        .main!.tempMin)!.round()
                                        .toString()}\u2103 / Max: ${(controller
                                        .currentWeatherData!.main!.tempMax)!
                                        .round().toString()}\u2103',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                      color: AppColors.headersBlackColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 1.h)
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 25.w,
                                    height: 25.w,
                                    child: LottieBuilder.asset(
                                      AssetsManager.cloudyAnim,
                                    ),
                                  ),
                                  Text(
                                    'Wind ${controller.currentWeatherData!.wind!
                                        .speed} m/s',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                      color: AppColors.headersBlackColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
