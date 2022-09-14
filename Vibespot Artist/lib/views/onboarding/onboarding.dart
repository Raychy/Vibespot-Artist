import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vsartist/constants/app_colors.dart';
import 'package:vsartist/constants/pref_keys.dart';
import 'package:vsartist/core/preference_store/preference_store.dart';
import 'package:vsartist/core/router/app_route.dart';
import 'package:vsartist/views/account/account-lander.dart'; 

import './model.dart';
import './page_view_indicator.dart';

class Onboarding extends StatelessWidget implements AppRoute {
  @override
  String get routeNam => routeName;

  static String get routeName => 'onboarding';

  @override
  Widget get page => this;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: GymTutorialBody(),
    );
  }
}

class GymTutorialBody extends StatefulWidget {
  GymTutorialBody({Key? key}) : super(key: key);

  @override
  GymTutorialBodyState createState() => GymTutorialBodyState();
}

class GymTutorialBodyState extends State<GymTutorialBody> {
  late var deviceSize;
  PageController? _pageController;
  CrossFadeState _bottomState = CrossFadeState.showFirst;

  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController!.addListener(_pageListener);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController!.removeListener(_pageListener);
    _pageController!.dispose();
  }

  _navigate() {
    GetIt.I<PreferenceStore>().setBool(PrefKeys.SEEN_SLIDE, true);
    Navigator.of(context).pushReplacementNamed(AccountLander.routeName);
  }

  void _pageListener() {
    if (_pageController!.hasClients) {
      double page =
          _pageController!.page ?? _pageController!.initialPage as double;
      setState(() {
        if (page >= 4) {
          _bottomState = CrossFadeState.showSecond;
        } else {
          _bottomState = CrossFadeState.showFirst;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        PageView.builder(
          controller: _pageController,
          itemCount: pages.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage(pages[index].background!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: deviceSize.height * 0.20,
                    ),
                    Image.asset(
                      pages[index].assetImagePath!,
                      width: MediaQuery.of(context).size.width * 0.35,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                        padding: pages[index].title == ''
                            ? const EdgeInsets.only(top: 0.0)
                            : EdgeInsets.only(top: deviceSize.height * 0.10)),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 30.0),
                      child: Text(
                        pages[index].title!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: pages[index].textColor,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'josefinSlab',
                            fontSize: 25.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 30.0),
                      child: Text(
                        pages[index].text!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: pages[index].textColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 14.0),
                      ),
                    ),
                  ],
                ));
          },
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 40),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 55.0,
              alignment: Alignment.center,
              child: AnimatedCrossFade(
                crossFadeState: _bottomState,
                duration: Duration(milliseconds: 300),
                firstChild: PageIndicators(
                    pageController: _pageController, done: _navigate),
                secondChild: Center(
                  child: SizedBox(
                    width: 250,
                    child: CupertinoButton(
                      color: AppColors.PRIMARY,
                      onPressed: _navigate,
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PageIndicators extends StatelessWidget {
  final PageController? pageController;
  final Function()? done;

  const PageIndicators({Key? key, this.pageController, this.done})
      : super(key: key);

  Widget skipButton() => InkWell(
        onTap: () {
          pageController!.animateToPage(4,
              curve: Curves.decelerate, duration: Duration(milliseconds: 500));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
          child: Text(
            'Skip',
            textAlign: TextAlign.end,
            style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.w700,
                fontSize: 19.0),
          ),
        ),
      );

  Widget finishButton(context) => InkWell(
        onTap: done,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
          child: Text(
            'Finish',
            textAlign: TextAlign.end,
            style: TextStyle(
                color: Colors.orangeAccent,
                fontWeight: FontWeight.w700,
                fontSize: 19.0),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
            alignment: Alignment.center,
            child: PageViewIndicator(
              controller: pageController,
              pageCount: 5,
              color: Colors.black,
            )),
        Align(
          alignment: Alignment.centerRight,
          child:
              //pageController.page!=null &&  pageController.page >= 3 ? finishButton(context) : skipButton(),
              pageController!.page != null && pageController!.page!.round() >= 4
                  ? finishButton(context)
                  : skipButton(),
        ),
      ],
    );
  }
}
