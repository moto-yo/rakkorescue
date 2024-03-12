import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../assets/title_images.dart';
import '../../state/game_state.dart';
import '../../interfaces/state_type.dart';
import '../../widgets/virtual_screen.dart';

class TitleView extends StatefulWidget {
  const TitleView({super.key});

  @override
  State<TitleView> createState() => _TitleViewState();
}

class _TitleViewState extends State<TitleView> with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();

    _pageViewController = PageController();
    _tabController = TabController(length: TitleImages.pages.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();

    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VirtualScreen(
      bgColor: const Color(0xff9adec4),
      width: 1442,
      height: 2058,
      child: Column(
        children: [
          Container(
            width: 936,
            height: 364,
            margin: const EdgeInsets.symmetric(vertical: 41.0) + const EdgeInsets.symmetric(horizontal: 258.0),
            child: const Image(image: TitleImages.logo),
          ),
          Container(
            width: 1146,
            height: 985,
            margin: const EdgeInsets.symmetric(vertical: 2.0) + const EdgeInsets.symmetric(horizontal: 150.0),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: TitleImages.pageDlg,
                fit: BoxFit.contain,
              ),
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                PageView(
                  /// [PageView.scrollDirection] defaults to [Axis.horizontal].
                  /// Use [Axis.vertical] to scroll vertically.
                  controller: _pageViewController,
                  onPageChanged: _handlePageViewChanged,
                  children: List.generate(
                    TitleImages.pages.length,
                    (i) => Center(
                      child: RakkoPage(index: i),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 61,
                  child: PageIndicator(
                    tabController: _tabController,
                    currentPageIndex: _currentPageIndex,
                    onUpdateCurrentPageIndex: _updateCurrentPageIndex,
                    isOnDesktopAndWeb: _isOnDesktopAndWeb,
                  ),
                ),
              ],
            ),
          ),
          Consumer<GameState>(
            builder: (context, gameState, _) {
              return GestureDetector(
                onTap: () {
                  if (gameState.stateType == StateType.title) {
                    gameState.triggerStart();
                  }
                },
                child: Container(
                  width: 894,
                  height: 286,
                  margin: const EdgeInsets.symmetric(horizontal: 274.0) + const EdgeInsets.only(top: 56, bottom: 30 + 187 + 66),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: TitleImages.startBtn,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    if (!_isOnDesktopAndWeb) {
      return;
    }
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  bool get _isOnDesktopAndWeb {
    if (kIsWeb) {
      return true;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return true;
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        return false;
    }
  }
}

class RakkoPage extends StatelessWidget {
  const RakkoPage({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    String titlePage;

    switch (index) {
      case 0:
        titlePage = AppLocalizations.of(context)?.titlePage0 ?? 'titlePage0';

        break;

      case 1:
        titlePage = AppLocalizations.of(context)?.titlePage1 ?? 'titlePage1';

        break;

      case 2:
        titlePage = AppLocalizations.of(context)?.titlePage2 ?? 'titlePage2';

        break;

      case 3:
        titlePage = AppLocalizations.of(context)?.titlePage3 ?? 'titlePage3';

        break;

      case 4:
        titlePage = AppLocalizations.of(context)?.titlePage4 ?? 'titlePage4';

        break;

      case 5:
      default:
        titlePage = AppLocalizations.of(context)?.titlePage5 ?? 'titlePage5';

        break;
    }

    return Column(children: [
      Container(
        width: 1040,
        height: 420,
        margin: const EdgeInsets.only(top: 143.0, bottom: 23.0) + const EdgeInsets.symmetric(horizontal: 53.0),
        child: Image(image: TitleImages.pages[index]),
      ),
      Container(
        width: 987,
        // height: 271,
        margin: const EdgeInsets.symmetric(horizontal: 79.5),
        child: Text(
          titlePage,
          style: const TextStyle(
            fontSize: 62,
            color: Color(0xFF5a4133),
          ),
        ),
      ),
    ]);
  }
}

// デスクトップと web用のページ インジケーター
class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.tabController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
    required this.isOnDesktopAndWeb,
  });

  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;
  final bool isOnDesktopAndWeb;

  @override
  Widget build(BuildContext context) {
    if (!isOnDesktopAndWeb) {
      return const SizedBox.shrink();
    }

    return Transform.scale(
      scale: 3.0, // 拡大率
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            splashRadius: 16.0,
            hoverColor: const Color(0x55f9f6d9),
            highlightColor: const Color(0xfff9f6d9),
            padding: EdgeInsets.zero,
            onPressed: () {
              if (currentPageIndex == 0) {
                return;
              }
              onUpdateCurrentPageIndex(currentPageIndex - 1);
            },
            icon: const Icon(
              Icons.arrow_left_rounded,
              size: 32.0,
              color: Color(0xffc3aa72),
            ),
          ),
          TabPageSelector(
            controller: tabController,
            color: const Color(0xffc3aa72),
            selectedColor: const Color(0xfff2a75b),
          ),
          IconButton(
            splashRadius: 16.0,
            hoverColor: const Color(0x55f9f6d9),
            highlightColor: const Color(0xfff9f6d9),
            padding: EdgeInsets.zero,
            onPressed: () {
              if (currentPageIndex == TitleImages.pages.length - 1) {
                return;
              }
              onUpdateCurrentPageIndex(currentPageIndex + 1);
            },
            icon: const Icon(
              Icons.arrow_right_rounded,
              size: 32.0,
              color: Color(0xffc3aa72),
            ),
          ),
        ],
      ),
    );
  }
}
