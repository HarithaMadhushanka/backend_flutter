import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final double width;
  final double height;
  final Function onPressed;
  final Text text;
  final Icon icon;

  const GradientButton({@required this.width, @required this.height, @required this.onPressed, @required this.text, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80),
        gradient: LinearGradient(
          colors: [Colors.white70, Colors.white.withOpacity(0.3)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: MaterialButton(
        onPressed: this.onPressed,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: StadiumBorder(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            text,
            icon,
          ],
        ),
      ),
    );
  }
}
