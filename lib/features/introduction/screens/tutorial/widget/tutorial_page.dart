import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_guide/assets/themes/theme.dart';
import 'package:flutter_guide/common/widgets/gap.dart';
import 'package:flutter_guide/features/app/core/widgets/app_bottom_button.dart';
import 'package:flutter_guide/features/introduction/widgets/app_bar_trailing_button.dart';
import 'package:flutter_guide/features/introduction/widgets/app_tab_view.dart';
import 'package:flutter_guide/features/navigation/service/app_router.gr.dart';
import 'package:flutter_guide/features/translations/service/generated/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Tutorial page:
class TutorialPage extends StatelessWidget {
  /// Constructor for [TutorialPage]
  const TutorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: _TutorialPageBody(),
        ),
      ),
    );
  }
}

class _TabData {
  final String title;

  final String description;

  final String assetsPath;

  _TabData({
    required this.title,
    required this.description,
    required this.assetsPath,
  });
}

class _TutorialTabController extends ChangeNotifier {
  final int length;

  int get index => _value;

  set index(int newValue) {
    if (newValue < 0 || newValue >= length || _value == newValue) return;

    _value = newValue;

    notifyListeners();
  }

  int _value = 0;

  _TutorialTabController({
    required this.length,
    int? initial,
  }) {
    _value = initial ?? 0;
  }
}

class _TutorialPageBody extends StatefulWidget {
  const _TutorialPageBody();

  @override
  State<_TutorialPageBody> createState() => _TutorialPageBodyState();
}

class _TutorialPageBodyState extends State<_TutorialPageBody> {
  late final _TutorialTabController _controller;

  var _tabs = <_TabData>[];

  @override
  void didChangeDependencies() {
    final translation = AppTranslations.of(context);

    _tabs = [
      _TabData(
        title: translation.tutorialTitle1,
        description: translation.tutorialSubtitle1,
        assetsPath: 'assets/images/tutorial_page_1.svg',
      ),
      _TabData(
        title: translation.tutorialTitle2,
        description: translation.tutorialSubtitle2,
        assetsPath: 'assets/images/tutorial_page_2.svg',
      ),
      _TabData(
        title: translation.tutorialTitle3,
        description: translation.tutorialSubtitle3,
        assetsPath: 'assets/images/tutorial_page_3.svg',
      ),
    ];

    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    _controller = _TutorialTabController(
      length: 3,
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
        if (notification is UserScrollNotification) {
          if (notification.direction == ScrollDirection.forward) {
            _controller.index = _controller.index - 1;
          } else if (notification.direction == ScrollDirection.reverse) {
            _controller.index = _controller.index + 1;
          } else if (notification.direction == ScrollDirection.idle &&
              _controller.index != DefaultTabController.of(context)!.index) {
            _controller.index = DefaultTabController.of(context)!.index;
          }
        }

        return true;
      },
      child: Stack(
        children: [
          TabBarView(
            children: _tabs
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 52),
                    child: Center(
                      child: _TabWidget(tabData: e),
                    ),
                  ),
                )
                .toList(),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              if (_controller.index != _tabs.length - 1) {
                return Align(
                  alignment: Alignment.topRight,
                  child: AppBarTrailingButton(
                    onTap: _skip,
                  ),
                );
              }

              return Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: AppBottomButton(
                    onTap: _skip,
                    text: AppTranslations.of(context).letsGo,
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Align(
                alignment: const Alignment(0, .7),
                child: AppTabView(
                  length: _tabs.length,
                  currentIndex: _controller.index,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _skip() => AutoRouter.of(context).replace(
        const MainRoute(),
      );
}

class _TabWidget extends StatelessWidget {
  final _TabData tabData;

  const _TabWidget({
    required this.tabData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          tabData.assetsPath,
          height: 98,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        const Gap(dimension: 40),
        Text(
          tabData.title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
          textAlign: TextAlign.center,
        ),
        const Gap(dimension: 8),
        Text(
          tabData.description,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: AppTheme.of(context).thirdColor,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
