// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:money_management/constants/color.dart';
import 'package:money_management/providers/transactionprovider.dart';
import 'package:money_management/widgets/bottomnavigation.dart';
import 'package:money_management/widgets/widgets.dart';
import 'package:provider/provider.dart';

Future<void> alertMessage(BuildContext context, {required String id}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Delete !', style: TextStyle(color: prColor)),
        content: const Text('Are you Sure?', style: TextStyle(color: prColor)),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No', style: TextStyle(color: prColor))),
          TextButton(
              onPressed: () async {
                Provider.of<TransactionProvider>(context, listen: false)
                    .deleteTransaction(id);
                await Provider.of<TransactionProvider>(context, listen: false)
                    .refreshTransaction();
                Provider.of<TransactionProvider>(context, listen: false)
                    .refreshTransaction();
                showToast(message: 'Deleted');
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const BottomNavigation(),
                ));
              },
              child: const Text('Yes', style: TextStyle(color: prColor)))
        ],
      );
    },
  );
}
