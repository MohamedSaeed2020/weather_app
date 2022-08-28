import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_app/controllers/next_five_days_forecast_controller.dart';
import 'package:weather_app/core/theme/colors.dart';
import 'package:weather_app/data_layer/models/next_five_days_forecast_model/five_days_data.dart';

class NextFiveDaysForecastChart extends StatelessWidget {
  const NextFiveDaysForecastChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NextFiveDaysForecastController>(builder: (controller) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 30.h,
        child: Card(
          elevation: 1.h,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1.5.h),
          ),
          child: controller.nextFiveDaysForecastIsLoading
              ? const Center(
                  child: SpinKitFadingCircle(
                    color: AppColors.primaryColor,
                    size: 50.0,
                  ),
                )
              : SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  series: <ChartSeries<FiveDayData, String>>[
                    SplineSeries<FiveDayData, String>(
                      dataSource: controller.fiveDaysData,
                      xValueMapper: (FiveDayData fiveDaysData, _) => fiveDaysData.dateTime,
                      yValueMapper: (FiveDayData fiveDaysData, _) => fiveDaysData.temp,
                    ),
                  ],
                ),
        ),
      );
    });
  }
}
