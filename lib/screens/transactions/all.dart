import 'package:flutter/material.dart';
import 'package:money_management/constants/color.dart';
import 'package:money_management/constants/itemlist.dart';
import 'package:money_management/providers/transactionprovider.dart';
import 'package:money_management/screens/transactions/widgets/allhead.dart';
import 'package:money_management/widgets/bottomsheet.dart';
import 'package:money_management/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
        builder: (context, transprovider, child) {
      return Scaffold(
        backgroundColor: secColor,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * .25,
                    width: MediaQuery.of(context).size.width,
                    child: transactionHead(context)),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      prText600(data: 'Transactions History', size: 17.0),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final transactionprovider =
                      Provider.of<TransactionProvider>(context, listen: false);
                  final transactionlist = transactionprovider.translist;
                  if (transactionlist.isEmpty ||
                      index >= transactionlist.length) {
                    return const Center(
                      child: Text(
                        'No Data',
                        style: TextStyle(
                            color: prColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    );
                  }
                  final reportdata = transactionlist[index];
                  return ListTile(
                    onTap: () {
                      bottomSheet(context, reportdata);
                    },
                    leading: Image.asset(
                      'assets/icons/${reportdata.category}.png',
                      height: 40,
                    ),
                    title: prText600(data: reportdata.name, size: 17.0),
                    subtitle: customText(
                        color: unselected,
                        data:
                            '${mon[reportdata.datetime.month - 1]}-${reportdata.datetime.day}/${reportdata.datetime.year}',
                        thickness: th600),
                    trailing: Text(
                      '₹ ${reportdata.amount.toString()}',
                      style: TextStyle(
                          color: reportdata.type == 'Income'
                              ? incomecol
                              : expensecol,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  );
                }, childCount: transprovider.translist.length),
              )
            ],
          ),
        ),
      );
    });
  }
}
