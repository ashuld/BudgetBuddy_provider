import 'package:flutter/material.dart';
import 'package:money_management/constants/color.dart';
import 'package:money_management/db/functions/piechartcal.dart';
import 'package:money_management/providers/transactionprovider.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

Widget pieChart(context, dataMap) {
  return Consumer<TransactionProvider>(
    builder: (context, value, child) {
      var total = foodtotal() +
          entertainmenttotal() +
          educationtotal() +
          otherexpensestotal() +
          transportationtotal() +
          personalcaretotal() +
          loanstotal() +
          medicaltotal();
      return total == 0
          ? const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  SizedBox(
                      child: Text('No Data',
                          style: TextStyle(fontSize: 20, color: prColor))),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  PieChart(
                    chartType: ChartType.disc,
                    dataMap: dataMap,
                    chartLegendSpacing: 40,
                    ringStrokeWidth: 40,
                    chartRadius: MediaQuery.of(context).size.width * 0.75,
                    colorList: chartcolor,
                    centerText: 'Expense',
                    legendOptions: const LegendOptions(
                        showLegendsInRow: true,
                        legendTextStyle: TextStyle(
                            color: prColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        legendPosition: LegendPosition.bottom),
                    chartValuesOptions: const ChartValuesOptions(
                        showChartValueBackground: false,
                        showChartValues: true,
                        decimalPlaces: 1,
                        showChartValuesOutside: false,
                        chartValueBackgroundColor: secColor,
                        chartValueStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            );
    },
  );
}
