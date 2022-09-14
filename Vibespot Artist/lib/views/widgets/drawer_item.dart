import 'package:flutter/material.dart';
import 'package:vsartist/core/router/route_transisions.dart';

class DrawerItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final String? routeName;
  final Function()? action;
  const DrawerItem(
      {Key? key,
      required this.title,
      required this.icon,
      this.routeName,
      this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: action ??
          () {
            Navigator.of(context).pop();
            if (routeName != null)
              Navigator.of(context)
                  .pushNamed(routeName!, arguments: Transissions.slide_left);
          },
      // height: 45,
      child: Row(
        children: [
          IconTheme(data: IconTheme.of(context).copyWith(), child: icon),
          SizedBox(width: 20),
          Text(title, style: Theme.of(context).textTheme.caption?.copyWith())
        ],
      ),
    );
  }
}
