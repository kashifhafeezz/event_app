import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_app/features/speakers/data/models/speaker_model.dart';
import 'package:event_app/utils/extension/context_extension.dart';
import 'package:event_app/utils/navigation/app_navigation.dart';
import 'package:event_app/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class SpeakerListTile extends StatelessWidget {
  const SpeakerListTile({required this.speakerModel, super.key});
  final SpeakerModel speakerModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 16,
      horizontalTitleGap: 0,
      onTap: () {
        AppNavigation().navigateToSpeakerDetailScreen(
          context: context,
          speakerModel: speakerModel,
        );
      },
      leading: CachedNetworkImage(
        imageUrl: speakerModel.speakerImage,
        width: 80,
        height: 80,
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
      title: Padding(
        padding: const EdgeInsets.only(left: 7),
        child: Text(
          speakerModel.speakerName,
          style: AppTextStyles()
              .titleSmallTextStyle(context: context)
              ?.copyWith(fontWeight: AppFontWeight().semiBold),
        ),
      ),
      subtitle: Html(
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
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 18,
        color: Colors.grey.shade400,
      ),
    );
  }
}
