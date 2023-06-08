import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_management/db/model/transactions.dart';
import 'package:money_management/providers/transactionprovider.dart';

double total = 0;
final box = Hive.box<TransactionModel>(transactiondb);

class IncomeExpenseProvider extends ChangeNotifier {
  double totaler() {
    var totals = box.values.toList();
    List a = [0.0];
    for (var i = 0; i < totals.length; i++) {
      a.add(totals[i].type == 'Income'
          ? totals[i].amount
          : totals[i].amount * -1);
    }
    total = a.reduce((value, element) => value + element);
    return total;
  }

  double incometotaler() {
    var totals = box.values.toList();
    List a = [0.0];
    for (var i = 0; i < totals.length; i++) {
      a.add(totals[i].type == 'Income' ? totals[i].amount : 0);
    }
    total = a.reduce((value, element) => value + element);
    return total;
  }

  double expensetotaler() {
    var totals = box.values.toList();
    List a = [0.0];
    for (var i = 0; i < totals.length; i++) {
      a.add(totals[i].type == 'Income' ? 0 : totals[i].amount * -1);
    }
    total = a.reduce((value, element) => value + element);
    return total;
  }
}
