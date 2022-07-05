import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final GestureTapCallback? onTap;
  final Widget? right;
  final Color? color;
  final Color? fontColor;
  final Color? iconColor;

  const MenuItem({
    Key? key,
    required this.icon,
    required this.label,
    this.onTap,
    this.right,
    this.color,
    this.fontColor,
    this.iconColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(
        icon,
        color: iconColor,
        size: 14,
      ),
      const SizedBox(width: 15),
      Text(label, style: TextStyle(
        color: fontColor,
        fontSize: 15,
      )),
    ];

    if (right != null) {
      items.add(const Spacer());
      items.add(right!);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: onTap,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: items,
          ),
        ),
      ),
    );
  }
}

class HeaderItem extends StatelessWidget {
  final String label;
  const HeaderItem({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          Container(
            height: 0.5,
            color: Colors.grey.withOpacity(0.5),
          ),
          const SizedBox(height: 25),
          Text(label,
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w500
              )
          ),
        ],
      ),
    );
  }
}