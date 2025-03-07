import 'package:event_app/features/Home/presentation/widget/home_app_bar.dart';
import 'package:event_app/utils/common/app_drawer_widget.dart';
import 'package:event_app/utils/common/fade_animation.dart';
import 'package:event_app/utils/constants/app_const.dart';
import 'package:event_app/utils/constants/app_utils.dart';
import 'package:event_app/utils/navigation/app_navigation.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawerWidget(),
      appBar: HomeAppBar(
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(AppConst().screenHorizontalPadding),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: AppUtils().homeViewModelList.length,
        itemBuilder: (context, index) {
          final item = AppUtils().homeViewModelList[index];
          return FadeAnimation(
            delay: index.toDouble(),
            child: GestureDetector(
              onTap: () {
                AppNavigation().navigateToFeatureScreen(
                  context: context,
                  route: item.route,
                );
              },
              behavior: HitTestBehavior.opaque,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: item.color,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(item.image),
              ),
            ),
          );
        },
      ),
    );
  }
}
