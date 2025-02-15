import 'package:filmy/src/utils/utils.dart';
import 'package:flutter/material.dart';

class BuildCustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final bool showBackButton;
  final double preferredHeight;
  final bool showTrailingIcon;
  final Widget? trailingIcon;
  final double? trailingIconSize;
  final VoidCallback? onTrailingIconPressed;

  const BuildCustomAppBarWidget({
    Key? key,
    required this.title,
    this.centerTitle = false,
    this.showBackButton = true,
    this.preferredHeight = 60.0,
    this.showTrailingIcon = false,
    this.trailingIcon,
    this.trailingIconSize,
    this.onTrailingIconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headlineLarge
            ?.copyWith(fontWeight: FontWeight.w800, fontSize: 22),
      ),
      centerTitle: centerTitle,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      leading: showBackButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () {
                pop(context);
              },
            )
          : null,
      actions: showTrailingIcon && trailingIcon != null
          ? [
              IconButton(
                iconSize: trailingIconSize ?? 24.0,
                icon: trailingIcon!,
                onPressed: onTrailingIconPressed,
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(preferredHeight);
}
