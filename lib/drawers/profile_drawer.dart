import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          //  UserAccountsDrawerHeader(
          //   accountName: const Text("John Doe"),
          //   accountEmail: const Text("john.doe@example.com"),
          //   currentAccountPicture: const CircleAvatar(
          //     backgroundImage: NetworkImage(
          //         "https://via.placeholder.com/150"), // Replace with your image URL
          //   ),
          //   decoration: BoxDecoration(
          //     color: Colors.black.withOpacity(0.3),
          //   ),
          // ),
          SizedBox(height: 40.h),
          ClipOval(
            child: Image.asset(
              'assets/images/men.jpg',
              width: 70.0, 
              height: 70.0,
              fit: BoxFit.cover, 
            ),
          ),
            SizedBox(height: 10.h),
           const Text("John Doe"),

          SizedBox(height: 10.h),
           Divider(color: Colors.white.withOpacity(0.4),),
          SizedBox(height: 10.h),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.pop(context); 
             
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {
              Navigator.pop(context); 
              
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              Navigator.pop(context); 
            },
          ),
        ],
      ),
    );
  }
}
