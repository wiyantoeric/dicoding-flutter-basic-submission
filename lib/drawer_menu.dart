import 'package:flutter/material.dart';
import 'package:renote/community_list.dart';
import 'package:renote/community_screen.dart';
import 'package:renote/home_screen.dart';
import 'package:renote/login.dart';
import 'package:renote/user.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1c7c81),
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(color: Color.fromARGB(255, 240, 240, 240)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // DrawerItem bagian atas
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    color: const Color(0xFF1c7c81),
                    child: drawerProfileItem(
                      profilePicture: 'images/user-profile-picture.jpg',
                      title: user.username!,
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  // Drawer main item
                  drawerMenuItemTitle(
                      icon: Icons.home,
                      title: 'Home',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      }),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Divider(color: Color(0xFF1c7c81)),
                  ),
                  drawerSectionTitle(text: 'Community'),
                  Column(
                    children: communityList.map((item) {
                      return drawerSectionItem(
                          title: item.name,
                          communityLogo: item.communityImage!,
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CommunityScreen(community: item)));
                          });
                    }).toList(),
                  ),
                ],
              ),

              // DrawerItem bagian bawah
              Column(
                children: [
                  drawerMenuItemTitle(
                      icon: Icons.logout,
                      title: 'Sign out',
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const LoginScreen();
                        }));
                      }),
                  const SizedBox(height: 12),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget drawerMenuItemTitle({
  IconData? icon,
  required String title,
  bool isProfile = false,
  VoidCallback? onTap,
}) {
  return ListTile(
    leading: Icon(icon),
    title: Text(
      title,
    ),
    onTap: onTap,
  );
}

Widget drawerSectionItem({
  String communityLogo = 'default-community-logo.jpg',
  required String title,
  bool isProfile = false,
  VoidCallback? onTap,
}) {
  return ListTile(
    leading: Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          width: 1,
          color: const Color.fromARGB(255, 122, 122, 122),
        )
      ),
      child: Image.asset(communityLogo),
    ),
    dense: true,
    title: Text(title),
    onTap: onTap,
  );
}

Widget drawerProfileItem(
    {String profilePicture = 'images/default-profile-image.png',
    required String title,
    Text? subtitle,
    bool isProfile = false}) {
  return ListTile(
    leading: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              width: 2,
              color: const Color(0xFFF4F9F9),
            )),
        child: CircleAvatar(
          backgroundImage: AssetImage(profilePicture),
          backgroundColor: const Color(0xFFCCF2F4),
        )),
    title: Text(
      title,
      style: const TextStyle(color: Colors.white, fontFamily: 'Poppins'),
    ),
    subtitle: subtitle,
  );
}

Widget drawerSectionTitle({required String text}) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(left: 16, top: 12, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
    ),
  );
}
