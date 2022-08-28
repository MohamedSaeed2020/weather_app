import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/core/theme/colors.dart';

class UnderlineRow extends StatefulWidget {
  const UnderlineRow({Key? key}) : super(key: key);

  @override
  UnderlineRowState createState() => UnderlineRowState();
}

class UnderlineRowState extends State<UnderlineRow> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20.w,
      child: Row(
        children: [
          Container(
            height: 0.5.h,
            width: 5.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5.w),
              ),
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(
            width: 2.w,
          ),
          Expanded(
            child: Container(
              height: 0.5.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.w),
                ),
                color: AppColors.lightGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
