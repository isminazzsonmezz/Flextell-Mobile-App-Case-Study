import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    super.key,
    required this.title,
  });
  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // Hero'yu kapatır
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      centerTitle: true,
    );
  }
}