import 'package:flutter/material.dart';
import 'package:money_management/constants/color.dart';
import 'package:money_management/constants/itemlist.dart';
import 'package:money_management/providers/transactionprovider.dart';
import 'package:money_management/widgets/bottomsheet.dart';
import 'package:money_management/widgets/widgets.dart';
import 'package:provider/provider.dart';

Widget homeList(BuildContext context, index) {
  final transactionprovider =
      Provider.of<TransactionProvider>(context, listen: false);
  final transactionlist = transactionprovider.translist;
  if (transactionlist.isEmpty || index >= transactionlist.length) {
    return const Center(
      child: Text(
        'No Data',
        style: TextStyle(
            color: prColor, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
  final data = transactionlist[index];
  return ListTile(
    onTap: () {
      bottomSheet(context, data);
    },
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Image.asset(
        'assets/icons/${data.category}.png',
        height: 40,
      ),
    ),
    title: prText600(data: data.name, size: 17.0),
    subtitle: customText(
        data:
            '${mon[data.datetime.month - 1]}-${data.datetime.day}/${data.datetime.year}',
        thickness: th600,
        color: unselected),
    trailing: customText(
        data: '₹ ${data.amount.toString()}',
        size: 20.0,
        thickness: th600,
        color: data.type == 'Income' ? incomecol : expensecol),
  );
}
