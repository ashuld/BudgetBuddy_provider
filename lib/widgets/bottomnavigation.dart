import 'package:flutter/material.dart';
import 'package:money_management/constants/color.dart';
import 'package:money_management/providers/btmnavprovider.dart';
import 'package:money_management/screens/addtransaction/addtr.dart';
import 'package:money_management/widgets/widgets.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationProvider>(
        builder: (context, indexProvider, child) {
      return Scaffold(
        body: indexProvider.screen[indexProvider.indexColour],
        backgroundColor: secColor,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScreenAddTransaction(),
                  ));
            },
            backgroundColor: prColor,
            child: secIcon(icon: Icons.add)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Padding(
            padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                    onTap: () {
                      indexProvider.setIndexColor(0);
                    },
                    child: customIcon(
                        icon: Icons.home,
                        size: 30.0,
                        color: indexProvider.indexColour == 0
                            ? prColor
                            : unselected)),
                customBox(width: 40.0),
                GestureDetector(
                    onTap: () {
                      indexProvider.setIndexColor(1);
                    },
                    child: customIcon(
                        color: indexProvider.indexColour == 1
                            ? prColor
                            : unselected,
                        icon: Icons.pie_chart_outline_outlined,
                        size: 30.0)),
              ],
            ),
          ),
        ),
      );
    });
  }
}
