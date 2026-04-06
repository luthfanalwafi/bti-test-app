import 'package:bti_test_app/commons/custom_nav_bar_item.dart';
import 'package:bti_test_app/pages/bookmark/index.dart';
import 'package:bti_test_app/pages/home/index.dart';
import 'package:bti_test_app/pages/profile/index.dart';
import 'package:bti_test_app/pages/search/index.dart';
import 'package:bti_test_app/services/color_theme.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController controller = PageController();
  PageStorageBucket bucket = PageStorageBucket();
  int selectedBottomNavBar = 0;

  void selectBottomNavBar(int index) {
    setState(() {
      selectedBottomNavBar = index;
      controller.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          PageStorage(
            bucket: bucket,
            child: PageView(
              controller: controller,
              physics: NeverScrollableScrollPhysics(),
              children: [
                HomePage(key: PageStorageKey<String>('home')),
                SearchPage(key: PageStorageKey<String>('search')),
                BookmarkPage(key: PageStorageKey<String>('bookmark')),
                ProfilePage(key: PageStorageKey<String>('profile')),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        color: white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: Offset(2, 0),
                          ),
                        ],
                      ),
                      child: SafeArea(
                        top: false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomNavigationBarItem(
                              icon: Icons.home,
                              onTap: () => selectBottomNavBar(0),
                              label: 'Home',
                              isSelected: selectedBottomNavBar == 0,
                            ),
                            CustomNavigationBarItem(
                              icon: Icons.search,
                              onTap: () => selectBottomNavBar(1),
                              label: 'Search',
                              isSelected: selectedBottomNavBar == 1,
                            ),
                            CustomNavigationBarItem(
                              icon: Icons.bookmark_border_outlined,
                              onTap: () => selectBottomNavBar(2),
                              label: 'Bookmark',
                              isSelected: selectedBottomNavBar == 2,
                            ),
                            CustomNavigationBarItem(
                              icon: Icons.person_outline,
                              onTap: () => selectBottomNavBar(3),
                              label: 'Profile',
                              isSelected: selectedBottomNavBar == 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      extendBody: true,
    );
  }
}
