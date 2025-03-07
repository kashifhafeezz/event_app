import 'package:event_app/core/localization/l10n/l10n.dart';
import 'package:event_app/core/services/secure_storage_service.dart';
import 'package:event_app/utils/common/app_drawer_widget.dart';
import 'package:event_app/utils/common/app_header_widget.dart';
import 'package:event_app/utils/common/common_app_bar.dart';
import 'package:event_app/utils/common/fade_animation.dart';
import 'package:event_app/utils/extension/context_extension.dart';
import 'package:event_app/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class BadgeScreen extends StatefulWidget {
  const BadgeScreen({super.key});

  @override
  State<BadgeScreen> createState() => _BadgeScreenState();
}

class _BadgeScreenState extends State<BadgeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _storageService = SecureStorageService();
  String doctorName = '';
  String qrCode = '';

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    final user = await _storageService.getUserData();
    setState(() {
      doctorName = user?.doctorName ?? '';
      qrCode = user?.qrCode ?? '';
    });
  }

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
            const AppHeaderWidget(),
            FadeAnimation(
              delay: 1,
              child: Container(
                // height: context.mqHeight * 0.53,
                width: context.mqWidth - 30,
                margin: const EdgeInsets.only(top: 35),
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: context.colorScheme.onPrimary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 3,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        qrCode,
                        errorBuilder: (context, error, stackTrace) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        context.l10n.scan_qr_code,
                        style: AppTextStyles().labelLargeTextStyle(
                          context: context,
                          textColor: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Center(
                        child: Text(
                          '"$doctorName"',
                          style: AppTextStyles()
                              .titleLargeTextStyle(
                                context: context,
                                textColor: context.colorScheme.primary,
                              )
                              ?.copyWith(
                                fontWeight: AppFontWeight().semiBold,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
