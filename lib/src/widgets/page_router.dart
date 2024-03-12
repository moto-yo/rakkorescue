import 'package:flutter/material.dart';

// tab選択で表示される 1枚ページ
class RoutePage {
  const RoutePage(this.view, this.icon, this.label);

  final Widget view;
  final Widget icon;
  final String label;
}

// 下バー NavigationBar・横バー NavigationRail の tabで選択中の 1枚ページ RoutePageを表示する
class PageRouter extends StatefulWidget {
  const PageRouter({super.key, required this.routePages});

  final List<RoutePage> routePages;

  @override
  State<PageRouter> createState() => _PageRouterState();
}

// break point
// [参考] https://m1.material.io/layout/responsive-ui.html#responsive-ui-breakpoints
//   600dp未満  Portrait  handset   1段
//   840dp未満            tablet    600 ≦ 2段 < 840
//   960dp未満  Landscape handset   840 ≦ 3段
//  1280dp未満            tablet
//  1600dp以上                      中央寄せ

class _PageRouterState extends State<PageRouter> {
  int _selectedIndex = 0;
  final _pageViewController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    // print('${MediaQuery.of(context).size}');

    return NavigatorPopHandler(
        onPop: () {
          // 閉じる
          Navigator.pop(context);
        },
        // 足場: appBar, body, floatingActionButton, persistentFooterButtons, backgroundColor,...
        child: Scaffold(
            backgroundColor: const Color(0xff504133),
            resizeToAvoidBottomInset: false, // キーボードを出してもレイアウトが崩れないようにする
            bottomNavigationBar: (MediaQuery.of(context).size.width < 600)
                ? NavigationBar(
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: (int index) {
                      setState(() {
                        _pageViewController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                        );
                      });
                    },
                    destinations: widget.routePages.map((routePage) {
                      return NavigationDestination(
                        icon: routePage.icon,
                        label: routePage.label,
                      );
                    }).toList(),
                    labelBehavior: NavigationDestinationLabelBehavior.alwaysHide)
                : null,
            body: SafeArea(
              child: Row(children: [
                Visibility(
                  visible: 600 <= MediaQuery.of(context).size.width,
                  child: NavigationRail(
                    extended: 960 <= MediaQuery.of(context).size.width,
                    destinations: widget.routePages.map((routePage) {
                      return NavigationRailDestination(
                        icon: routePage.icon,
                        label: Text(
                          routePage.label,
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: (index) {
                      setState(() {
                        _pageViewController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                        );
                      });
                    },
                  ),
                ),
                Expanded(
                    child: PageView(
                        scrollDirection: (MediaQuery.of(context).size.width < 600) ? Axis.horizontal : Axis.vertical,
                        controller: _pageViewController,
                        children: widget.routePages.map((routerPage) => routerPage.view).toList(),
                        onPageChanged: (index) {
                          setState(() {
                            _selectedIndex = index;
                          });
                        }))
              ]),
            )));
  }
}
