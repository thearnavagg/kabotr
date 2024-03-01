import 'package:flutter/material.dart';
import 'package:kabotr/features/auth/ui/auth_register_screen.dart';
import 'package:kabotr/themes/app_images.dart';
import 'package:onboarding/onboarding.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late Material materialButton;
  late int index;
  final onboardingPagesList = [
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: background,
          border: Border.all(
            width: 0.0,
            color: background,
          ),
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              Image.asset(AppImages.kingqueen),
              const SizedBox(height: 25),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 45.0, vertical: 45),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'For Whom??',
                    style: pageTitleStyle.copyWith(fontSize: 30),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Kabotr is for GenZ Maharajas and Maharanis like you',
                    style: pageInfoStyle.copyWith(fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const SizedBox(
                height: 150,
              ),
            ],
          ),
        ),
      ),
    ),
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: background,
          border: Border.all(
            width: 0.0,
            color: background,
          ),
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              Image.asset(AppImages.letter),
              const SizedBox(height: 25),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 45.0, vertical: 45),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Change And Rise',
                    style: pageTitleStyle.copyWith(fontSize: 30),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 45.0, vertical: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Share your ideas, thoughts or anything through sending Patr',
                    style: pageInfoStyle.copyWith(fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const SizedBox(
                height: 150,
              )
            ],
          ),
        ),
      ),
    ),
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: background,
          border: Border.all(
            width: 0.0,
            color: background,
          ),
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              Image.asset(AppImages.logo),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 45.0, vertical: 45.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Easy Access',
                    style: pageTitleStyle.copyWith(fontSize: 30),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 45.0, vertical: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Reach your Patr anytime from any devices anywhere',
                    style: pageInfoStyle.copyWith(fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const SizedBox(
                height: 150,
              ),
            ],
          ),
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    materialButton = _skipButton();
    index = 0;
  }

  Material _skipButton({void Function(int)? setIndex}) {
    return Material(
      borderRadius: defaultSkipButtonBorderRadius,
      color: defaultSkipButtonColor,
      child: InkWell(
        borderRadius: defaultSkipButtonBorderRadius,
        onTap: () {
          if (setIndex != null) {
            index = 2;
            setIndex(2);
          }
        },
        child: const Padding(
          padding: defaultSkipButtonPadding,
          child: Text(
            'Skip',
            style: defaultSkipButtonTextStyle,
          ),
        ),
      ),
    );
  }

  Material get _signupButton {
    return Material(
      borderRadius: defaultProceedButtonBorderRadius,
      color: defaultProceedButtonColor,
      child: InkWell(
        borderRadius: defaultProceedButtonBorderRadius,
        onTap: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) => AuthRegisterScreen()));
        },
        child: const Padding(
          padding: defaultProceedButtonPadding,
          child: Text(
            'Authenticate',
            style: defaultProceedButtonTextStyle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Onboarding(
        pages: onboardingPagesList,
        onPageChange: (int pageIndex) {
          index = pageIndex;
        },
        startPageIndex: 0,
        footerBuilder: (context, dragDistance, pagesLength, setIndex) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: background,
              border: Border.all(
                width: 0.0,
                color: background,
              ),
            ),
            child: ColoredBox(
              color: background,
              child: Padding(
                padding: const EdgeInsets.all(45.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIndicator(
                      netDragPercent: dragDistance,
                      pagesLength: pagesLength,
                      indicator: Indicator(
                        indicatorDesign: IndicatorDesign.line(
                          lineDesign: LineDesign(
                            lineType: DesignType.line_uniform,
                          ),
                        ),
                      ),
                    ),
                    index == pagesLength - 1
                        ? _signupButton
                        : _skipButton(setIndex: setIndex)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
