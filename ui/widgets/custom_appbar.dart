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
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(16),

      ),
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          
          children: [
            ClipOval(
              child: Image.asset(
                logoPath,
                width: 30,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: [
                /* Image.asset(profile!), */
                const SizedBox(width: 8),
                Text(name, style: TextStyle(color: Colors.white, fontWeight:FontWeight.bold ),),
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
