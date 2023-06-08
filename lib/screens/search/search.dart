// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:money_management/constants/color.dart';
import 'package:money_management/providers/transactionprovider.dart';
import 'package:money_management/screens/search/widgets/daterangefilter.dart';
import 'package:money_management/screens/search/widgets/searchresult.dart';
import 'package:provider/provider.dart';

class ScreenSearch extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        appBarTheme: const AppBarTheme(
      color: secColor,
    ));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(
            Icons.close,
            color: prColor,
          )),
      Consumer<TransactionProvider>(builder: (context, trprovider, child) {
        return PopupMenuButton(
          color: secColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          icon: const Icon(
            Icons.calendar_month_rounded,
            color: prColor,
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
                onTap: () async {
                  trprovider.all();
                },
                child: const Text(
                  'All',
                  style: TextStyle(color: prColor),
                )),
            PopupMenuItem(
                onTap: () async {
                  trprovider.today();
                },
                child: const Text(
                  'Today',
                  style: TextStyle(color: prColor),
                )),
            PopupMenuItem(
                onTap: () async {
                  trprovider.yesterday();
                },
                child: const Text(
                  'Yesterday',
                  style: TextStyle(color: prColor),
                )),
            PopupMenuItem(
                onTap: () async {
                  trprovider.lastweek();
                },
                child: const Text(
                  'Last Week',
                  style: TextStyle(color: prColor),
                )),
            PopupMenuItem(
                onTap: () async {
                  if (first == null || second == null) {
                    return;
                  } else {
                    trprovider.daterange(first, second);
                  }
                },
                child: const WidgetDateRangePicker())
          ],
        );
      }),
      Consumer<TransactionProvider>(builder: (context, trprovider, child) {
        return PopupMenuButton(
          color: secColor,
          icon: const Icon(
            Icons.more_vert,
            color: prColor,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          itemBuilder: (context) => [
            PopupMenuItem(
                onTap: () async {
                  trprovider.all();
                },
                child: const Text(
                  'All',
                  style: TextStyle(color: prColor),
                )),
            PopupMenuItem(
                onTap: () async {
                  trprovider.income();
                },
                child: const Text(
                  'Income',
                  style: TextStyle(color: prColor),
                )),
            PopupMenuItem(
                onTap: () async {
                  trprovider.expense();
                },
                child: const Text(
                  'Expense',
                  style: TextStyle(color: prColor),
                ))
          ],
        );
      })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: prColor,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return WidgetSearchResult(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return WidgetSearchResult(query: query);
  }
}
