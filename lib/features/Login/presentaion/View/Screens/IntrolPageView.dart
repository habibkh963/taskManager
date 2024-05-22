import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Widget/RegisterAsCustomer.dart';
import '../Widget/Shared/paint5.dart';

class IntrolPageView extends StatelessWidget {
  IntrolPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        //   title: Text(''),
        // ),
        body: SizedBox(
      child: Stack(clipBehavior: Clip.none, children: [
        Positioned(
          bottom: 0,
          left: -0.5,
          right: 0,
          child: CustomPaint(
            size: Size(MediaQuery.sizeOf(context).width,
                MediaQuery.sizeOf(context).height * 0.5),
            //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
            painter: Paint5(),
          ),
        ),

        Positioned(
            top: 200.h, right: 10.w, left: 10.w, child: RegisterAsCustomer())

        // Obx(() {
        //   return AnimatedPositioned(
        //       duration: Duration(seconds: 1),
        //       left: 10.w,
        //       bottom: introController.page.value == 3 ? 120.h : -200.h,
        //       child: SvgPicture.asset(
        //         'assets/Intro/Delivery-amico.svg',
        //         width: 400.w,
        //       ));
        // }),
      ]),
    ));
  }
}
