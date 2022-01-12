import 'package:flutter/material.dart';
import 'package:motel/app/ui/appTheme.dart';

class RoundCornerButtonWidget extends StatelessWidget {
  const RoundCornerButtonWidget(
      {Key? key, this.bgColor, this.prefixIcon, this.title, this.onTap})
      : super(key: key);
  final Color? bgColor;
  final Widget? prefixIcon;
  final String? title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppTheme.getTheme().dividerColor,
            blurRadius: 8,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
          highlightColor: Colors.transparent,
          onTap: () {
            if (onTap != null) onTap!();
          },
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (prefixIcon != null) ...[
                  prefixIcon!,
                  SizedBox(
                    width: 4,
                  )
                ],
                Text(
                  title ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
