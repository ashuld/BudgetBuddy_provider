import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_management/db/functions/db_functions.dart';
import 'package:money_management/db/model/transactions.dart';

class TransactionProvider extends ChangeNotifier {
  final transactiondb = 'expense';
  List<TransactionModel> translist = [];


  Future<void> reset() async {
    final transactionData = await Hive.openBox<TransactionModel>(transactiondb);
    transactionData.clear();
    translist.clear();
    transfilter.value.clear();
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
    transfilter.value.clear();
    translist = transactionData.values.toList();
    transfilter.value.addAll(translist);
    notifyListeners();
    return translist;
  }

  Future<void> refreshTransaction() async {
    final transactionList = await getAllTransactions();
    transactionList
        .sort((first, second) => second.datetime.compareTo(first.datetime));
    translist = transactionList;
    transfilter.value.addAll(translist);
    notifyListeners();
  }

  Future<void> deleteTransaction(String transId) async {
    final transactionData = await Hive.openBox<TransactionModel>(transactiondb);
    await transactionData.delete(transId);
    translist.clear();
    transfilter.value.clear();
    translist = transactionData.values.toList();
    transfilter.value.addAll(translist);
    await refreshTransaction();
    notifyListeners();
  }

  Future<void> editTransaction(TransactionModel obj) async {
    final transactionDB = await Hive.openBox<TransactionModel>(transactiondb);
    transactionDB.put(obj.id, obj);
    translist.clear();
    transfilter.value.clear();
    translist = transactionDB.values.toList();
    transfilter.value.addAll(translist);
    refreshTransaction();
    notifyListeners();
  }
}
