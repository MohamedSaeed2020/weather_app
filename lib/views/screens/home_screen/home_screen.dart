import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/core/theme/colors.dart';
import 'package:weather_app/views/screens/home_screen/widgets/current_location_weather.dart';
import 'package:weather_app/views/screens/home_screen/widgets/other_cities_forecast.dart';
import 'package:weather_app/views/screens/home_screen/widgets/next_five_days_forecast_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const CurrentLocationWeatherWidget(),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 1.h,),
                  Text(
                    'OTHER CITIES FORECAST',
                    style:
                    Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.headersBlackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const OtherCitiesForecast(),
                  Container(
                    padding: EdgeInsets.only(top: 1.h),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'NEXT FIVE DAYS FORECAST',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.headersBlackColor,
                          ),
                        ),
                        const Icon(
                          Icons.next_plan_outlined,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                  ),
                  const NextFiveDaysForecastChart(),
                  SizedBox(height: 1.h,),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
