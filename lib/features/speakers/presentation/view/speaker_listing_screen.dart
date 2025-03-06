import 'package:event_app/core/localization/l10n/l10n.dart';
import 'package:event_app/utils/common/app_drawer_widget.dart';
import 'package:event_app/utils/common/app_header_widget.dart';
import 'package:event_app/utils/common/common_app_bar.dart';
import 'package:event_app/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class SpeakerListingScreen extends StatefulWidget {
  const SpeakerListingScreen({super.key});

  @override
  State<SpeakerListingScreen> createState() => _SpeakerListingScreenState();
}

class _SpeakerListingScreenState extends State<SpeakerListingScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const AppDrawerWidget(),
      appBar: CommonAppBar(
        onMenuPressed: () {
          _scaffoldKey.currentState?.openEndDrawer();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppHeaderWidget(title: context.l10n.speakers),
            const SizedBox(height: 20),
            ListTile(
              leading: const CircleAvatar(radius: 30),
              title: Text(
                'Kashif sdsdsad',
                style: AppTextStyles()
                    .titleSmallTextStyle(context: context)
                    ?.copyWith(fontWeight: AppFontWeight().semiBold),
              ),
              subtitle: Text(
                'Kashif sdsdsad dsd asd sd ad ds d sdadadas ds dsad sadsad asd adasdsad asd sa',
                style: AppTextStyles()
                    .bodyMediumTextStyle(
                      context: context,
                      textColor: Colors.grey.shade600,
                    )
                    ?.copyWith(fontWeight: AppFontWeight().regular),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
