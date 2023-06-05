import 'package:flutter/material.dart';
import 'package:money_management/constants/color.dart';
import 'package:money_management/screens/settings/settings.dart';
import 'package:money_management/widgets/widgets.dart';

Widget header(name, phnno, mail) {
  return DrawerHeader(
    decoration: const BoxDecoration(color: prColor),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText(
                data: name,
                thickness: FontWeight.bold,
                color: secColor,
                size: 25.0),
            box10(),
            secText500(data: phnno, size: 14.0),
            box10(),
            secText500(data: mail, size: 14.0),
            box10(),
          ],
        )
      ],
    ),
  );
}

Widget tile2(context) {
  return ListTile(
      leading: prIcon(icon: Icons.settings),
      title: prText500(data: 'Settings', size: 18.0),
      onTap: () {
        Navigator.pop(context);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ScreenSettings(),
        ));
      });
}

Widget tile3(context) {
  return ListTile(
    leading: prIcon(icon: Icons.close),
    title: prText500(data: 'Close Drawer', size: 18.0),
    onTap: () {
      Navigator.of(context).pop();
    },
  );
}
