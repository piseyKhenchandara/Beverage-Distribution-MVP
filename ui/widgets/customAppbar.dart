import 'package:flutter/material.dart';

enum AppRole { depot, admin, driver }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
 
  final String name;
  final String logoPath;
  final String profile;
  final VoidCallback onMenuPressed;

  const CustomAppBar(
    
    this.name,
    {
    this.profile = "assets/profiles/depot_profile.png",
    this.logoPath = "assets/logos/logo.png",
    required this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(logoPath),
            Row(
              children: [
                Image.asset(profile!),
                const SizedBox(width: 8),
                Text(name),
              ],
            ),
            IconButton(onPressed: onMenuPressed, icon: Icon(Icons.menu)),
          ],
        ),
      ),
        
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
