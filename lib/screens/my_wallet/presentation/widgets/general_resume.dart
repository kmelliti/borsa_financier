import 'package:borsa_now_bis/core/di/di.dart';
import 'package:borsa_now_bis/core/models/chart_sales_model.dart';
import 'package:borsa_now_bis/screens/my_wallet/presentation/widgets/request_withdraw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../../../core/config/utils.dart';
import '../../../../core/theme/animated_buttons.dart';
import '../../../../core/theme/app_theme.dart';
import '../manager/my_wallet_controller.dart';
import 'fund_request.dart';

class GeneralResume extends StatefulWidget {
  GeneralResume({super.key});

  @override
  State<GeneralResume> createState() => _GeneralResumeState();
}

class _GeneralResumeState extends State<GeneralResume> {
 late String _selectedMonth;
 late String _selectedYear;

  final MyWalletController controller = getIt();

  @override
  void initState() {

    _selectedYear = DateTime.now().year.toString();
    _selectedMonth = DateTime.now().month.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // dateSelector((month) {
          //
          //   print("Date Month $month");
          // }, (year) {
          //   print("Date year $year");
          //
          // }),
          // Row(
          //   children: [
          //     Expanded(child: dropdownMonth()),
          //     SizedBox(width: 10),
          //     Expanded(child: dropdownYear()),
          //
          //   ],
          // ),

       //   SizedBox(height: 20),
          FutureBuilder(future: controller.getMyWalletDashboard(), builder: (c,snap){
            if(snap.connectionState == ConnectionState.waiting){
              return Center(child: getLoader());
            }
            if(snap.hasError){
              return Container();
            }
            return buildDashboard(context, snap.data!);
          }),

          SizedBox(height: 20),
          chartWidget(),
          SizedBox(height: 20),
          pushUpAnimation(buildButtons()),
          // Column(
          //   children: [
          //     ElevatedButton(onPressed: () {}, child: Text("withdraw".tr)),
          //
          //     SizedBox(height: 10),
          //     ElevatedButton(
          //       onPressed: () {},
          //       style: AppTheme.outlinedButtonStyle,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text("request_funds".tr),
          //           SizedBox(width: 10),
          //           SvgPicture.asset(
          //             "assets/icons/money.svg",
          //             width: 20,
          //             color: HexColor.fromHex(AppTheme.primaryColor),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),

          // Add more content here as needed
        ],
      ),
    );
  }

  Column buildButtons() {
    return Column(
      children: [
        AnimatedButton(onPressed: () {
          Get.to(WithdrawRequestPage());
        }, child: Text("withdraw".tr)),
        const SizedBox(height: 10),
        AnimatedButton(
          onPressed: () {
            Get.to(FundRequest());
          },
          style: AppTheme.outlinedButtonStyle,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("request_funds".tr),
              const SizedBox(width: 10),
              SvgPicture.asset(
                "assets/icons/money.svg",
                width: 20,
                color: HexColor.fromHex(AppTheme.primaryColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTile(
    BuildContext context,
    Color color,
    String amount,
    String title,
    String asset,
  ) {
    return pushUpAnimation(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
        ),
        child: Row(
          children: [
            SvgPicture.asset(asset),
            SizedBox(width: 5),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(

                fontSize: 20,
              ),
            ),
            Spacer(),
            Text(
              amount.toString(),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: HexColor.fromHex(AppTheme.primaryColor),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 5),
            SvgPicture.asset("assets/icons/sar.svg", width: 15),
          ],
        ),
      ),
    );
  }

  Widget chartWidget() {
    final ValueNotifier<bool> shakeUp = ValueNotifier(false);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitle("income_plans".tr),
          SizedBox(height: 20),
          dateSelector((month) {
            _selectedMonth = month;
            shakeUp.value = !shakeUp.value;
          }, (year) {
            _selectedYear = year.toString();
            shakeUp.value = !shakeUp.value;

          },false),
          SizedBox(height: 20),
          ValueListenableBuilder(
            valueListenable: shakeUp,
            builder: (context,_,__) {
              return FutureBuilder(
                  future: controller.getStats(_selectedYear, ""),
                  builder: (context,snap) {

                    if(snap.connectionState == ConnectionState.waiting){
                      return Center(child: LoadingAnimationWidget.halfTriangleDot(
                        color: HexColor.fromHex(AppTheme.primaryColor),
                        size: 40,

                      ),);
                    }
                    if(snap.connectionState == ConnectionState.done && !snap.hasError){
                      List<ChartSalesModel> data = snap.data??[];
                      if(data.isEmpty){
                        return Center(
                          child: Text("no_data".tr,style: Theme.of(context).textTheme.titleLarge,),
                        );
                      }
                      return SfCartesianChart(
                        primaryXAxis: CategoryAxis(
                          majorGridLines: const MajorGridLines(
                            width: 0,
                          ),
                        ),
                        primaryYAxis: NumericAxis(
                          majorGridLines: const MajorGridLines(
                            width: 0,
                          ),
                        ),
                        isTransposed: false,

                        legend: Legend(isVisible: false),
                        // Enable tooltip
                        tooltipBehavior: TooltipBehavior(enable: false),
                        series: <CartesianSeries<ChartSalesModel, String>>[
                          LineSeries<ChartSalesModel, String>(
                            color: Colors.red,
                            dashArray: [15, 15],
                            dataSource: data,
                            xValueMapper: (ChartSalesModel sales, _) => monthList[sales.month-1],
                            yValueMapper: (ChartSalesModel sales, _) => double.parse(sales.total),
                            name: 'Sales',
                            // Enable data label
                            dataLabelSettings: DataLabelSettings(isVisible: true),
                          ),
                        ],
                      );
                    }

                    return Container();
                  }
              );
            }
          )

        ],
      ),
    );

  }

  buildDashboard(BuildContext context, Map<String,dynamic> dashboard) {

    return Column(
      children: [
        SizedBox(height: 10),
        _buildTile(
          context,
          HexColor.fromHex("#FFF4D3"),
          dashboard['withdrawn'].toString(),
          "withdrawn".tr,
          "assets/icons/fly_money.svg",
        ),
        SizedBox(height: 10),
        _buildTile(
          context,
          HexColor.fromHex("#FFE8ED"),
          dashboard['balance'].toString(),
          "total_credit".tr,
          "assets/icons/wallet.svg",
        ),
        SizedBox(height: 10),
        _buildTile(
          context,
          HexColor.fromHex("#E9F0FF"),
          dashboard['funding'].toString(),
          "funds".tr,
          "assets/icons/money.svg",
        ),
      ],
    );
  }
}

