import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_management/db/model/transactions.dart';

class TransactionProvider extends ChangeNotifier {
  final transactiondb = 'expense';
  List<TransactionModel> translist = [];

  Future<void> reset() async {
    final transactionData = await Hive.openBox<TransactionModel>(transactiondb);
    transactionData.clear();
    translist.clear();
    refreshTransaction();
    // notifyListeners();
  }

  Future<void> addTransaction(TransactionModel value) async {
    final transactionData = await Hive.openBox<TransactionModel>(transactiondb);
    await transactionData.put(value.id, value);
    translist = transactionData.values.toList();
    notifyListeners();
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    final transactionData = await Hive.openBox<TransactionModel>(transactiondb);
    translist = transactionData.values.toList();
    return translist;
  }

  Future<void> refreshTransaction() async {
    final transactionList = await getAllTransactions();
    transactionList
        .sort((first, second) => second.datetime.compareTo(first.datetime));
    translist = [...transactionList];
    notifyListeners();
  }

  Future<void> deleteTransaction(String transId) async {
    final transactionData = await Hive.openBox<TransactionModel>(transactiondb);
    await transactionData.delete(transId);
    translist = transactionData.values.toList();
    await refreshTransaction();
  }

  Future<void> editTransaction(TransactionModel obj) async {
    final transactionDB = await Hive.openBox<TransactionModel>(transactiondb);
    transactionDB.put(obj.id, obj);
    translist = transactionDB.values.toList();
    refreshTransaction();
    notifyListeners();
  }
}
