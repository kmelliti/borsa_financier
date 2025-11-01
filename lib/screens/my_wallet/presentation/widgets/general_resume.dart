import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../../../core/config/utils.dart';
import '../../../../core/theme/app_theme.dart';

class GeneralResume extends StatelessWidget {
   GeneralResume({super.key});
  final List<_SalesData> data = [
    _SalesData('2020', 0),
    _SalesData('2021', 10),
    _SalesData('2022', 25),
    _SalesData('2023', 50),
    _SalesData('2024', 100),
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: dropdownMonth()),
              SizedBox(width: 10),
              Expanded(child: dropdownYear()),

            ],
          ),
          SizedBox(height: 10),
          _buildTile( context,HexColor.fromHex("#FFF4D3"),1000, "withdrawn".tr,"assets/icons/fly_money.svg"),
          SizedBox(height: 10),
          _buildTile( context,HexColor.fromHex("#FFE8ED"),1000, "total_credit".tr,"assets/icons/wallet.svg"),
          SizedBox(height: 10),
          _buildTile( context,HexColor.fromHex("#E9F0FF"),1000, "funds".tr,"assets/icons/money.svg"),
          SizedBox(height: 20),
          chartWidget(),
          SizedBox(height: 20),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {

                },
                child: Text("withdraw".tr),
              ),

              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {

                },
                style: AppTheme.outlinedButtonStyle,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("request_funds".tr),
                    SizedBox(width: 10,),
                    SvgPicture.asset("assets/icons/money.svg", width: 20,color: HexColor.fromHex(AppTheme.primaryColor),),
                  ],
                ),
              ),
            ],
          ),

          // Add more content here as needed
        ],
      ),
    );

  }
  Widget dropdownMonth() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),

      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: null,
          icon: const Icon(Icons.keyboard_arrow_down_sharp),
          hint: Text("month".tr),
          items: const [
            DropdownMenuItem(value: 'Small', child: Text('Small')),
            DropdownMenuItem(value: 'Medium', child: Text('Medium')),
            DropdownMenuItem(value: 'Large', child: Text('Large')),
          ],
          onChanged: (value) {},
        ),
      ),
    );
  }

  Widget dropdownYear() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),

      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: null,
          icon: const Icon(Icons.keyboard_arrow_down_sharp),
          hint: Text("year".tr),

          items: const [
            DropdownMenuItem(value: 'Small', child: Text('Small')),
            DropdownMenuItem(value: 'Medium', child: Text('Medium')),
            DropdownMenuItem(value: 'Large', child: Text('Large')),
          ],
          onChanged: (value) {},
        ),
      ),
    );
  }

  Widget _buildTile(BuildContext context,Color color, double amount , String title, String asset) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey))
      ),
      child: Row(
        children: [
          SvgPicture.asset(asset),
          SizedBox(width: 5,),
          Text(title,style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: HexColor.fromHex(AppTheme.primaryColor),
            fontSize: 20
          ),),
          Spacer(),
          Text(amount.toString(),style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: HexColor.fromHex(AppTheme.primaryColor),
              fontWeight: FontWeight.bold,
              fontSize: 20
          )),
          SizedBox(width: 5,),
          SvgPicture.asset("assets/icons/sar.svg", width: 20),


        ],
      ),
    );
  }

  Widget chartWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitle("income_plans".tr),
          SizedBox(height: 20,),
          Row(
            children: [
              dropdownMonth(),
              SizedBox(width: 10,),
              dropdownYear(),
            ],
          ),
          SizedBox(height: 20,),
          SfCartesianChart(
            primaryXAxis: CategoryAxis(
              majorGridLines: const MajorGridLines(width: 0),  // Remove vertical grid lines
            ),
            primaryYAxis: NumericAxis(
              majorGridLines: const MajorGridLines(width: 0),  // Remove horizontal grid lines
            ),
            isTransposed: false,
            //primaryXAxis: CategoryAxis(),

            // Chart title
          //  title: ChartTitle(text: 'Half yearly sales analysis'),
            // Enable legend
            legend: Legend(isVisible: false),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: false),
            series: <CartesianSeries<_SalesData, String>>[
              LineSeries<_SalesData, String>(
                color: Colors.red,
                dashArray: [15,15],
                dataSource: data,
                xValueMapper: (_SalesData sales, _) => sales.year,
                yValueMapper: (_SalesData sales, _) => sales.sales,
                name: 'Sales',
                // Enable data label
                dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
            ],
          )

        ],
      ),
    );
  }


}


class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}