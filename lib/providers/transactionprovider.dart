import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_management/db/model/transactions.dart';

const transactiondb = 'expense';

class TransactionProvider extends ChangeNotifier {
  List<TransactionModel> translist = [];
  List<TransactionModel> transfilter = [];

  Future<void> reset() async {
    final transactionData = await Hive.openBox<TransactionModel>(transactiondb);
    transactionData.clear();
    translist.clear();
    transfilter.clear();
    refreshTransaction();
  }

  Future<void> addTransaction(TransactionModel value) async {
    final transactionData = await Hive.openBox<TransactionModel>(transactiondb);
    await transactionData.put(value.id, value);
    await refreshTransaction();
    notifyListeners();
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    final transactionData = await Hive.openBox<TransactionModel>(transactiondb);
    translist.clear();
    translist = transactionData.values.toList();
    notifyListeners();
    return translist;
  }

  Future<void> refreshTransaction() async {
    translist.clear();
    final transactionList = await getAllTransactions();
    transactionList
        .sort((first, second) => second.datetime.compareTo(first.datetime));
    translist = transactionList;
    filterTransaction();
    notifyListeners();
  }

  Future<void> filterTransaction() async {
    transfilter.clear();
    final transactionList = await getAllTransactions();
    transactionList
        .sort((first, second) => second.datetime.compareTo(first.datetime));
    transfilter = transactionList;
  }

  Future<void> deleteTransaction(String transId) async {
    final transactionData = await Hive.openBox<TransactionModel>(transactiondb);
    await transactionData.delete(transId);
    await refreshTransaction();
    notifyListeners();
  }

  Future<void> editTransaction(TransactionModel obj) async {
    final transactionDB = await Hive.openBox<TransactionModel>(transactiondb);
    transactionDB.put(obj.id, obj);
    refreshTransaction();
    notifyListeners();
  }

  Future<List<TransactionModel>> all() async {
    transfilter.clear();
    await refreshTransaction();
    transfilter = translist;
    return transfilter;
  }

  Future<List<TransactionModel>> today() async {
    transfilter.clear();
    await refreshTransaction();
    transfilter = translist
        .where((element) =>
            element.datetime.day == DateTime.now().day &&
            element.datetime.month == DateTime.now().month &&
            element.datetime.year == DateTime.now().year)
        .toList();
    return transfilter;
  }

  Future<List<TransactionModel>> yesterday() async {
    transfilter.clear();
    await refreshTransaction();
    transfilter = translist
        .where((element) =>
            element.datetime.day == DateTime.now().day - 1 &&
            element.datetime.month == DateTime.now().month &&
            element.datetime.year == DateTime.now().year)
        .toList();
    return transfilter;
  }

  Future<List<TransactionModel>> lastweek() async {
    transfilter.clear();
    await refreshTransaction();
    final today = DateTime.now();
    final lastweek = today.subtract(const Duration(days: 7));
    transfilter = translist
        .where((element) => element.datetime.isAfter(lastweek))
        .toList();
    return transfilter;
  }

  Future<List<TransactionModel>> daterange(
      DateTime? first, DateTime? second) async {
    transfilter.clear();
    await refreshTransaction();
    transfilter = translist
        .where((element) =>
            element.datetime
                .isAfter(first!.subtract(const Duration(days: 1))) &&
            element.datetime.isBefore(second!.add(const Duration(days: 1))))
        .toList();
    return transfilter;
  }

  Future<List<TransactionModel>> income() async {
    transfilter.clear();
    await refreshTransaction();
    transfilter =
        translist.where((element) => element.type == 'Income').toList();
    return transfilter;
  }

  Future<List<TransactionModel>> expense() async {
    transfilter.clear();
    await refreshTransaction();
    transfilter =
        translist.where((element) => element.type == 'Expense').toList();
    return transfilter;
  }
}
