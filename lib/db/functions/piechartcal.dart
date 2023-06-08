import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/db/model/transactions.dart';
import 'package:money_management/providers/transactionprovider.dart';

double total = 0;
final box = Hive.box<TransactionModel>(transactiondb);

double foodtotal() {
  var totals = box.values.toList();
  List a = [0.0];
  for (var i = 0; i < totals.length; i++) {
    a.add(totals[i].category == 'Food' && totals[i].type == 'Expense'
        ? totals[i].amount
        : 0);
  }
  total = a.reduce((value, element) => value + element);
  return total;
}

double entertainmenttotal() {
  var totals = box.values.toList();
  List a = [0.0];
  for (var i = 0; i < totals.length; i++) {
    a.add(totals[i].category == 'Entertainment' && totals[i].type == 'Expense'
        ? totals[i].amount
        : 0);
  }
  total = a.reduce((value, element) => value + element);
  return total;
}

double educationtotal() {
  var totals = box.values.toList();
  List a = [0.0];
  for (var i = 0; i < totals.length; i++) {
    a.add(totals[i].category == 'Education' && totals[i].type == 'Expense'
        ? totals[i].amount
        : 0);
  }
  total = a.reduce((value, element) => value + element);
  return total;
}

double transportationtotal() {
  var totals = box.values.toList();
  List a = [0.0];
  for (var i = 0; i < totals.length; i++) {
    a.add(totals[i].category == 'Transportation' && totals[i].type == 'Expense'
        ? totals[i].amount
        : 0);
  }
  total = a.reduce((value, element) => value + element);
  return total;
}

double personalcaretotal() {
  var totals = box.values.toList();
  List a = [0.0];
  for (var i = 0; i < totals.length; i++) {
    a.add(totals[i].category == 'Personal Care' && totals[i].type == 'Expense'
        ? totals[i].amount
        : 0);
  }
  total = a.reduce((value, element) => value + element);
  return total;
}

double loanstotal() {
  var totals = box.values.toList();
  List a = [0.0];
  for (var i = 0; i < totals.length; i++) {
    a.add(totals[i].category == 'Loans' && totals[i].type == 'Expense'
        ? totals[i].amount
        : 0);
  }
  total = a.reduce((value, element) => value + element);
  return total;
}

double medicaltotal() {
  var totals = box.values.toList();
  List a = [0.0];
  for (var i = 0; i < totals.length; i++) {
    a.add(totals[i].category == 'Medical' && totals[i].type == 'Expense'
        ? totals[i].amount
        : 0);
  }
  total = a.reduce((value, element) => value + element);
  return total;
}

double otherexpensestotal() {
  var totals = box.values.toList();
  List a = [0.0];
  for (var i = 0; i < totals.length; i++) {
    a.add(totals[i].category == 'Other Expenses' && totals[i].type == 'Expense'
        ? totals[i].amount
        : 0);
  }
  total = a.reduce((value, element) => value + element);
  return total;
}
