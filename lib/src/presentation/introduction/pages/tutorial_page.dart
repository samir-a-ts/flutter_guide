import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/constants/theme.dart';
import 'package:flutter_guide/src/core/router/app_router.gr.dart';
import 'package:flutter_guide/src/core/translations/generated/l10n.dart';
import 'package:flutter_guide/src/presentation/core/gap.dart';
import 'package:flutter_guide/src/presentation/core/widgets/app_bottom_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: _TutorialPageBody(),
      ),
    );
  }
}

class _SkipButton extends StatelessWidget {
  const _SkipButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, top: 18),
      child: GestureDetector(
        behavior: HitTestBehavior.deferToChild,
        onTap: () {
          AutoRouter.of(context).replace(const PlacesListRoute());
        },
        child: Text(
          AppTranslations.of(context).skip,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              ),
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

class _TutorialPageBody extends StatefulWidget {
  const _TutorialPageBody();

  @override
  State<_TutorialPageBody> createState() => _TutorialPageBodyState();
}

class _TutorialPageBodyState extends State<_TutorialPageBody>
    with SingleTickerProviderStateMixin {
  final _tabs = <_TabData>[];

  late final TabController _controller;

  @override
  void didChangeDependencies() {
    final translation = AppTranslations.of(context);

    _tabs.addAll([
      _TabData(
        title: translation.tutorialTitle1,
        description: translation.tutorialSubitle1,
        assetsPath: "assets/images/tutorial_page_1.svg",
      ),
      _TabData(
        title: translation.tutorialTitle2,
        description: translation.tutorialSubitle2,
        assetsPath: "assets/images/tutorial_page_2.svg",
      ),
      _TabData(
        title: translation.tutorialTitle3,
        description: translation.tutorialSubitle3,
        assetsPath: "assets/images/tutorial_page_3.svg",
      ),
    ]);

    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    _controller = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            if (_controller.previousIndex == 2) {
              return const Align(
                alignment: Alignment.topRight,
                child: _SkipButton(),
              );
            }

            return Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: AppButtomButton(
                  onTap: () {},
                  text: AppTranslations.of(context).letsGo,
                ),
              ),
            );
          },
        ),
        TabBarView(
          controller: _controller,
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
      ],
    );
  }
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
        ),
        const Gap(dimension: 40),
        Text(
          tabData.title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primaryContainer,
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
