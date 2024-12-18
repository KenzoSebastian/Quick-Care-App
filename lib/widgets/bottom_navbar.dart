import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:quickcare_app/pages/detail_dokter_page.dart';
import 'package:quickcare_app/pages/edit_profile_page.dart';
import 'package:quickcare_app/pages/inbox_page.dart';
import 'package:quickcare_app/pages/order_dokter_page.dart';
import 'package:quickcare_app/pages/succes_page.dart';
import 'package:quickcare_app/providers/tab_bar_provider.dart';
import 'package:quickcare_app/utils/load_all_data.dart';
import '../pages/account_page.dart';
import '../pages/coming_soon_page.dart';
import '../pages/edit_order_page.dart';
import '../pages/history_page.dart';
import '../pages/home_page.dart';
import 'package:provider/provider.dart';
import '../pages/login_page.dart';
import '../pages/search_page.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});
  static const routeName = '/bottom-navbar';

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  List<Widget> _buildScreens() => [
        const HomePage(),
        const SearchPage(),
        const HistoryPage(),
        const AccountPage()
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.home,
            size: 30,
          ),
          title: ("Home"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey[400],
          routeAndNavigatorSettings: _routeMain()),
      PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.search,
            size: 30,
          ),
          title: ("Search"),
          activeColorPrimary: Colors.green,
          inactiveColorPrimary: Colors.grey[400],
          routeAndNavigatorSettings: _routeMain()),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.history,
          size: 30,
        ),
        title: ("History"),
        activeColorPrimary: Colors.orange,
        inactiveColorPrimary: Colors.grey[400],
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.account_circle_outlined,
          size: 30,
        ),
        title: ("Account"),
        activeColorPrimary: Colors.purple,
        inactiveColorPrimary: Colors.grey[400],
      ),
    ];
  }

  RouteAndNavigatorSettings _routeMain() => RouteAndNavigatorSettings(routes: {
        DetailDokterPage.routeName: (_) => const DetailDokterPage(),
        OrderDokter.routeName: (_) => const OrderDokter(),
        SuccesPage.routeName: (_) => const SuccesPage(),
        EditOrder.routeName: (_) => const EditOrder(),
        EditProfile.routeName: (_) => const EditProfile(),
        InboxPage.routeName: (_) => const InboxPage(),
        ComingSoonPage.routeName: (_) => const ComingSoonPage(),
        LoginPage.routeName: (_) => const LoginPage(),
      });

  NavBarAnimationSettings _AnimationSetting() => const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: true,
          duration: Duration(milliseconds: 400),
          screenTransitionAnimationType: ScreenTransitionAnimationType.slide,
        ),
      );

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  bool isDataInit = false;
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (isDataInit) return;
      await LoadAllData.loadAllData(context);
      isDataInit = true;
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TabBarProvider>(
        builder: (context, provider, child) {
          _controller.index = provider.tabIndex;
          return PersistentTabView(
            context,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            handleAndroidBackButtonPress: false,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            hideNavigationBarWhenKeyboardAppears: false,
            padding: const EdgeInsets.only(top: 3, bottom: 8),
            backgroundColor: Colors.white,
            isVisible: true,
            navBarStyle: NavBarStyle.style1,
            animationSettings: _AnimationSetting(),
          );
        },
      ),
    );
  }
}
