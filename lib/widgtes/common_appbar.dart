import 'package:ayurseva/core/app_theme/app_colors.dart';
import 'package:flutter/material.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool? automaticallyImplyLeading;
  const CommonAppbar({
    super.key,
    this.automaticallyImplyLeading=false
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.whiteColor,
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.notifications_active))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
