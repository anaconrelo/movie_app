import 'package:flutter/material.dart';
import 'package:movieapp/utils/dimension.dart';
import 'package:provider/provider.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dimension = Provider.of<Dimension>(context);
    return AppBar(
          centerTitle: true,
          elevation: 5,
          shadowColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: dimension.getWidth(20),
            children: [
              Image.asset('assets/images/android-chrome-512x512.png', height: 40, width: 40,),
              Text(
                'Anaconrelo Movies',
                style: textTheme.headlineLarge!.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}