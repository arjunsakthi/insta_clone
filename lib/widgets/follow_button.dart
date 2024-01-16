import 'package:flutter/material.dart';
import 'package:insta_clone/utils/colors.dart';

class FollowButton extends StatelessWidget {
  FollowButton({
    super.key,
    required this.function,
    required this.backgroundColor,
    required this.label,
  });
  final void Function() function;
  final Color backgroundColor;
  final label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 2),
      child: TextButton(
        onPressed: function,
        child: Container(
          width: 250,
          height: 27,
          decoration: BoxDecoration(
              border: Border.all(
                color: backgroundColor == blueColor
                    ? blueColor
                    : Colors
                        .grey /*apply trinary condition for color wrt color */,
              ),
              borderRadius: BorderRadius.circular(5),
              color: backgroundColor),
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: backgroundColor == mobileBackgroundColor ||
                        backgroundColor == blueColor
                    ? Colors.white
                    : Colors
                        .black /*apply trinary condition for color wrt color */,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
