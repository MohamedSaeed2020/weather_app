import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/core/helpers/assets_paths.dart';
import 'package:weather_app/core/theme/colors.dart';
import 'package:weather_app/controllers/home_controller.dart';

class OtherCitiesForecast extends StatelessWidget {
  const OtherCitiesForecast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return SizedBox(
        height: 20.h,
        child: controller.topFiveCitiesIsLoading
            ? const Center(
                child: SpinKitFadingCircle(
                  color: AppColors.primaryColor,
                  size: 50.0,
                ),
              )
            : controller.topFiveCitiesForecast.isEmpty
                ? Center(
                    child: Text(
                      'There is no data available !!!',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.headersBlackColor,
                          ),
                    ),
                  )
                : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => const VerticalDivider(
                      color: AppColors.bodyColor,
                      width: 5,
                    ),
                    itemCount: controller.topFiveCitiesForecast.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 35.w,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1.5.h),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                controller.topFiveCitiesForecast[index].name
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.headersBlackColor,
                                    ),
                              ),
                              Text(
                                '${(controller.topFiveCitiesForecast[index].main!.temp!).round().toString()}\u2103',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.headersBlackColor,
                                    ),
                              ),
                              SizedBox(
                                width: 15.w,
                                height: 15.w,
                                child: LottieBuilder.asset(
                                    AssetsManager.cloudyAnim),
                              ),
                              Expanded(
                                child: Text(
                                  '${controller.topFiveCitiesForecast[index].weather![0].description}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          color: AppColors.headersBlackColor,
                                          fontSize: 12.sp,
                                          overflow: TextOverflow.ellipsis),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      );
    });
  }
}
