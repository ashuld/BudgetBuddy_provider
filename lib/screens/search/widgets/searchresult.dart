import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:money_management/constants/color.dart';
import 'package:money_management/constants/deletepopup.dart';
import 'package:money_management/db/model/transactions.dart';
import 'package:money_management/providers/transactionprovider.dart';
import 'package:money_management/screens/edittransaction/edittransaction.dart';
import 'package:money_management/screens/search/widgets/searchcard.dart';
import 'package:provider/provider.dart';

class WidgetSearchResult extends StatelessWidget {
  final String query;
  const WidgetSearchResult({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: secColor,
      child: Consumer<TransactionProvider>(
        builder: (context, newvalue, child) {
          return newvalue.transfilter.isEmpty
              ? const Center(
                  child: Text(
                    'No Data',
                    style: TextStyle(
                        color: prColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    final value = newvalue.transfilter[index];
                    if (value.category
                            .toLowerCase()
                            .contains(query.toLowerCase().trim()) ||
                        value.amount
                            .toString()
                            .toLowerCase()
                            .contains(query.toLowerCase().trim()) ||
                        value.name
                            .toString()
                            .toLowerCase()
                            .contains(query.toLowerCase().trim())) {
                      return Slidable(
                          startActionPane: ActionPane(
                              motion: const StretchMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    alertMessage(context,
                                        id: value.id.toString());
                                  },
                                  backgroundColor: secColor,
                                  borderRadius: BorderRadius.circular(10),
                                  foregroundColor: expensecol,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                                SlidableAction(
                                    onPressed: (context) {
                                      final TransactionModel transmodel =
                                          TransactionModel(
                                              type: value.type,
                                              category: value.category,
                                              name: value.name,
                                              amount: value.amount,
                                              datetime: value.datetime,
                                              note: value.note,
                                              id: value.id);
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => EditTransaction(
                                          transactionlist: transmodel,
                                        ),
                                      ));
                                    },
                                    backgroundColor: secColor,
                                    borderRadius: BorderRadius.circular(10),
                                    foregroundColor: prColor,
                                    icon: Icons.edit,
                                    label: 'Edit')
                              ]),
                          key: Key(value.id.toString()),
                          child: WidgetSearchCard(
                            modelObj: value,
                          ));
                    } else {
                      return Container();
                    }
                  },
                  itemCount: newvalue.transfilter.length,
                );
        },
      ),
    );
  }
}
