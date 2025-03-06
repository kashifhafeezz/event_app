import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_app/features/speakers/data/models/speaker_model.dart';
import 'package:event_app/utils/common/app_header_widget.dart';
import 'package:event_app/utils/common/common_app_bar.dart';
import 'package:event_app/utils/extension/context_extension.dart';
import 'package:event_app/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class SpeakerDetailScreen extends StatelessWidget {
  const SpeakerDetailScreen({required this.speakerModel, super.key});
  final SpeakerModel speakerModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(onMenuPressed: () {}, isSideMenuRequired: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppHeaderWidget(),
            Container(
              height: context.mqHeight * 0.56,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CachedNetworkImage(
                    imageUrl: speakerModel.speakerImage,
                    width: 220,
                    height: 220,
                    errorWidget: (context, url, error) {
                      return CircleAvatar(
                        backgroundColor: context.colorScheme.primary,
                        radius: 27,
                        child: Icon(
                          Icons.image_not_supported_rounded,
                          color: context.colorScheme.onPrimary,
                          size: 28,
                        ),
                      );
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   speakerModel.speakerDesignation,

                      //   style: AppTextStyles()
                      //       .labelLargeTextStyle(context: context),
                      // ),
                      Html(
                        data: speakerModel.speakerDesignation,
                        style: {
                          'p': Style(
                            color: Colors.grey.shade600,
                            fontWeight: AppFontWeight().regular,
                            padding: HtmlPaddings.zero,
                            margin: Margins.zero,
                          ),
                          'strong': Style(
                            fontWeight: FontWeight.bold,
                          ),
                          'a': Style(
                            color: Colors.blue,
                            textDecoration: TextDecoration.underline,
                          ),
                        },
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 5, bottom: 10, left: 8),
                        child: Text(
                          speakerModel.speakerName,
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
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
