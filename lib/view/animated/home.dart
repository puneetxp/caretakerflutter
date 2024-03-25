import 'dart:async';
import 'package:flutter/material.dart';
import '../../theme/constant.dart';
import '../../layout/adaptive.dart';
import 'dart:math' as math;

const _horizontalPadding = 32.0;
const _horizontalDesktopPadding = 81.0;
const _carouselItemDesktopMargin = 8.0;
const _carouselHeightMin = 240.0;
const _carouselItemMobileMargin = 4.0;
const _carouselItemWidth = 296.0;
double _carouselHeight(double scaleFactor, BuildContext context) =>
    math.max(_carouselHeightMin * 1 * scaleFactor, _carouselHeightMin);

class _AnimatedHomePage extends StatefulWidget {
  const _AnimatedHomePage({
    required this.restorationId,
    required this.carouselCards,
    required this.isSplashPageAnimationFinished,
  });

  final String restorationId;
  final List<Widget> carouselCards;
  final bool isSplashPageAnimationFinished;

  @override
  _AnimatedHomePageState createState() => _AnimatedHomePageState();
}

class _AnimatedHomePageState extends State<_AnimatedHomePage>
    with RestorationMixin, SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Timer? _launchTimer;
  final RestorableBool _isMaterialListExpanded = RestorableBool(false);
  final RestorableBool _isCupertinoListExpanded = RestorableBool(false);
  final RestorableBool _isOtherListExpanded = RestorableBool(false);

  @override
  String get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_isMaterialListExpanded, 'material_list');
    registerForRestoration(_isCupertinoListExpanded, 'cupertino_list');
    registerForRestoration(_isOtherListExpanded, 'other_list');
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    if (widget.isSplashPageAnimationFinished) {
      // To avoid the animation from running when changing the window size from
      // desktop to mobile, we do not animate our widget if the
      // splash page animation is finished on initState.
      _animationController.value = 1.0;
    } else {
      // Start our animation halfway through the splash page animation.
      _launchTimer = Timer(
        halfSplashPageAnimationDuration,
        () {
          _animationController.forward();
        },
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _launchTimer?.cancel();
    _launchTimer = null;
    _isMaterialListExpanded.dispose();
    _isCupertinoListExpanded.dispose();
    _isOtherListExpanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          // Makes integration tests possible.
          key: const ValueKey('HomeListView'),
          primary: true,
          restorationId: 'home_list_view',
          children: [
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.all(10.00),
              child: _GalleryHeader(),
            ),
            _MobileCarousel(
              animationController: _animationController,
              restorationId: 'home_carousel',
              children: widget.carouselCards,
            ),
            // Container(
            //   margin:
            //       const EdgeInsets.symmetric(horizontal: _horizontalPadding),
            //   child: _CategoriesHeader(),
            // ),
            // _AnimatedCategoryItem(
            //   startDelayFraction: 0.00,
            //   controller: _animationController,
            //   child: CategoryListItem(
            //       key: const PageStorageKey<GalleryDemoCategory>(
            //         GalleryDemoCategory.material,
            //       ),
            //       restorationId: 'home_material_category_list',
            //       category: GalleryDemoCategory.material,
            //       imageString: 'assets/icons/material/material.png',
            //       demos: Demos.materialDemos(localizations),
            //       initiallyExpanded:
            //           _isMaterialListExpanded.value || isTestMode,
            //       onTap: (shouldOpenList) {
            //         _isMaterialListExpanded.value = shouldOpenList;
            //       }),
            // ),
            // _AnimatedCategoryItem(
            //   startDelayFraction: 0.05,
            //   controller: _animationController,
            //   child: CategoryListItem(
            //       key: const PageStorageKey<GalleryDemoCategory>(
            //         GalleryDemoCategory.cupertino,
            //       ),
            //       restorationId: 'home_cupertino_category_list',
            //       category: GalleryDemoCategory.cupertino,
            //       imageString: 'assets/icons/cupertino/cupertino.png',
            //       demos: Demos.cupertinoDemos(localizations),
            //       initiallyExpanded:
            //           _isCupertinoListExpanded.value || isTestMode,
            //       onTap: (shouldOpenList) {
            //         _isCupertinoListExpanded.value = shouldOpenList;
            //       }),
            // ),
            // _AnimatedCategoryItem(
            //   startDelayFraction: 0.10,
            //   controller: _animationController,
            //   child: CategoryListItem(
            //       key: const PageStorageKey<GalleryDemoCategory>(
            //         GalleryDemoCategory.other,
            //       ),
            //       restorationId: 'home_other_category_list',
            //       category: GalleryDemoCategory.other,
            //       imageString: 'assets/icons/reference/reference.png',
            //       demos: Demos.otherDemos(localizations),
            //       initiallyExpanded: _isOtherListExpanded.value || isTestMode,
            //       onTap: (shouldOpenList) {
            //         _isOtherListExpanded.value = shouldOpenList;
            //       }),
            // ),
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: GestureDetector(
            onVerticalDragEnd: (details) {
              if (details.velocity.pixelsPerSecond.dy > 200) {
                ToggleSplashNotification().dispatch(context);
              }
            },
            child: SafeArea(
              child: Container(
                height: 40,
                // If we don't set the color, gestures are not detected.
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ToggleSplashNotification extends Notification {}

class _GalleryHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Header(
      color: Theme.of(context).colorScheme.primaryContainer,
      text: "",
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key, required this.color, required this.text});

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: EdgeInsets.only(
          top: isDisplayDesktop(context) ? 63 : 15,
          bottom: isDisplayDesktop(context) ? 21 : 11,
        ),
        child: SelectableText(
          text,
          style: Theme.of(context).textTheme.headlineMedium!.apply(
                color: color,
                fontSizeDelta:
                    isDisplayDesktop(context) ? desktopDisplay1FontDelta : 0,
              ),
        ),
      ),
    );
  }
}

class _MobileCarousel extends StatefulWidget {
  const _MobileCarousel({
    required this.animationController,
    this.restorationId,
    required this.children,
  });

  final AnimationController animationController;
  final String? restorationId;
  final List<Widget> children;

  @override
  _MobileCarouselState createState() => _MobileCarouselState();
}

class _MobileCarouselState extends State<_MobileCarousel>
    with RestorationMixin, SingleTickerProviderStateMixin {
  late PageController _controller;

  final RestorableInt _currentPage = RestorableInt(0);

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_currentPage, 'carousel_page');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // The viewPortFraction is calculated as the width of the device minus the
    // padding.
    final width = MediaQuery.of(context).size.width;
    const padding = (_carouselItemMobileMargin * 2);
    _controller = PageController(
      initialPage: _currentPage.value,
      viewportFraction: (_carouselItemWidth + padding) / width,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  Widget builder(int index) {
    final carouselCard = AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double value;
        if (_controller.position.haveDimensions) {
          value = _controller.page! - index;
        } else {
          // If haveDimensions is false, use _currentPage to calculate value.
          value = (_currentPage.value - index).toDouble();
        }
        // .3 is an approximation of the curve used in the design.
        value = (1 - (value.abs() * .3)).clamp(0, 1).toDouble();
        value = Curves.easeOut.transform(value);

        return Transform.scale(
          scale: value,
          alignment: Alignment.center,
          child: child,
        );
      },
      child: widget.children[index],
    );

    // We only want the second card to be animated.
    if (index == 1) {
      return _AnimatedCarouselCard(
        controller: widget.animationController,
        child: carouselCard,
      );
    } else {
      return carouselCard;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _AnimatedCarousel(
      controller: widget.animationController,
      child: PageView.builder(
        // Makes integration tests possible.
        key: const ValueKey('studyDemoList'),
        onPageChanged: (value) {
          setState(() {
            _currentPage.value = value;
          });
        },
        controller: _controller,
        pageSnapping: false,
        itemCount: widget.children.length,
        itemBuilder: (context, index) => builder(index),
        allowImplicitScrolling: true,
      ),
    );
  }
}

/// Animates the carousel to come in from the right.
class _AnimatedCarousel extends StatelessWidget {
  _AnimatedCarousel({
    required this.child,
    required this.controller,
  }) : startPositionAnimation = Tween(
          begin: 1.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.200,
              0.800,
              curve: Curves.ease,
            ),
          ),
        );

  final Widget child;
  final AnimationController controller;
  final Animation<double> startPositionAnimation;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          SizedBox(height: _carouselHeight(.4, context)),
          AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return PositionedDirectional(
                start: constraints.maxWidth * startPositionAnimation.value,
                child: child!,
              );
            },
            child: SizedBox(
              height: _carouselHeight(.4, context),
              width: constraints.maxWidth,
              child: child,
            ),
          ),
        ],
      );
    });
  }
}

/// Animates a carousel card to come in from the right.
class _AnimatedCarouselCard extends StatelessWidget {
  _AnimatedCarouselCard({
    required this.child,
    required this.controller,
  }) : startPaddingAnimation = Tween(
          begin: _horizontalPadding,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.900,
              1.000,
              curve: Curves.ease,
            ),
          ),
        );

  final Widget child;
  final AnimationController controller;
  final Animation<double> startPaddingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Padding(
          padding: EdgeInsetsDirectional.only(
            start: startPaddingAnimation.value,
          ),
          child: child,
        );
      },
      child: child,
    );
  }
}
