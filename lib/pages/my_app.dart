// lib/main.dart
import 'package:app_dashboard_news/pages/managePage/manage_page.dart';
import 'package:app_dashboard_news/pages/settingPage/setting_page.dart';
import 'package:app_dashboard_news/pages/statePage/state_page.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

import '../apps/route/route_custom.dart';
import '../apps/route/route_name.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: primaryColor,
        canvasColor: canvasColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: Colors.white,
            fontSize: 46,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      initialRoute: RouteName.myHomePage,
      onGenerateRoute: RouterCustom.onGenerateRoute,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

const primaryColor = Color(0xFF6252DA);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF7777B6);

class _MyHomePageState extends State<MyHomePage> {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Builder(builder: (context) {
        final isSmallScreen = MediaQuery.of(context).size.width < 600;
        return Scaffold(
          key: _key,
          appBar: isSmallScreen
              ? AppBar(
                  title: const Text('Trang Quản Lí'),
                  leading: IconButton(
                    onPressed: () {
                      _key.currentState?.openDrawer();
                    },
                    icon: const Icon(Icons.menu),
                  ),
                )
              : null,
          drawer: SideBarXExample(
            controller: _controller,
          ),
          body: Row(
            children: [
              if (!isSmallScreen) SideBarXExample(controller: _controller),
              Expanded(
                child: Center(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      switch (_controller.selectedIndex) {
                        case 0:
                          _key.currentState?.closeDrawer();
                          return const StatsPage();
                        case 1:
                          _key.currentState?.closeDrawer();
                          return const ManagePage();
                        case 2:
                          _key.currentState?.closeDrawer();
                          return const SettingsPage();
                        case 3:
                          _key.currentState?.closeDrawer();
                          return const Center(
                            child: Text(
                              'Theme',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 40),
                            ),
                          );
                        default:
                          return const Center(
                            child: Text(
                              'Home',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 40),
                            ),
                          );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class SideBarXExample extends StatelessWidget {
  const SideBarXExample({Key? key, required SidebarXController controller})
      : _controller = controller,
        super(key: key);
  final SidebarXController _controller;
  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: const SidebarXTheme(
          decoration: BoxDecoration(
            color: canvasColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          selectedIconTheme: IconThemeData(color: Color(0xFF6252DA), size: 30),
          iconTheme: IconThemeData(color: Colors.white, size: 25),
          selectedTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          hoverTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
          )),
      extendedTheme: const SidebarXTheme(width: 250),
      footerDivider: Divider(color: Colors.white.withOpacity(0.8), height: 1),
      headerBuilder: (context, extended) {
        return const SizedBox(
          height: 100,
          child: Icon(
            Icons.person,
            size: 60,
            color: Colors.white,
          ),
        );
      },
      items: const [
        SidebarXItem(
          icon: Icons.dashboard,
          label: 'Thống Kê',
        ),
        SidebarXItem(icon: Icons.manage_accounts, label: 'Quản lí'),
        SidebarXItem(icon: Icons.settings, label: 'Setting'),
        SidebarXItem(icon: Icons.dark_mode, label: 'Light/Dark Mode'),
      ],
    );
  }
}
