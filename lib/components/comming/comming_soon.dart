import 'package:flutter/material.dart';

class ComingSoon extends StatelessWidget {
  final IconData icon;

  const ComingSoon(this.icon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 55, color: Colors.grey[300]),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            const Text(
              'Скоро, очень скоро...',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w300
              ),
            )
          ],
        ),
      ),
    );
  }
}