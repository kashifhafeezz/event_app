import 'package:event_app/core/localization/l10n/l10n.dart';
import 'package:event_app/features/agenda/data/models/agenda_model.dart';
import 'package:event_app/utils/extension/context_extension.dart';
import 'package:event_app/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AgendaListing extends StatelessWidget {
  const AgendaListing({required this.agendaItems, super.key});
  final List<AgendaModel> agendaItems;

  @override
  Widget build(BuildContext context) {
    if (agendaItems.isEmpty) {
      return const Text('No sessions available for this day.');
    }

    return Column(
      children: [
        Container(
          color: context.colorScheme.primary,
          height: 45,
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  context.l10n.time,
                  style: AppTextStyles().titleSmallTextStyle(
                    context: context,
                    textColor: context.colorScheme.onPrimary,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  context.l10n.details,
                  style: AppTextStyles().titleSmallTextStyle(
                    context: context,
                    textColor: context.colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: agendaItems.length,
          itemBuilder: (context, index) {
            final item = agendaItems[index];
            if (item.time.isEmpty || item.topic.isEmpty) {
              return const SizedBox();
            }
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      item.time,
                      style:
                          AppTextStyles().titleSmallTextStyle(context: context),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.topic,
                          style: AppTextStyles()
                              .titleSmallTextStyle(context: context),
                        ),
                        if (item.speakerName.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              item.speakerName,
                              style: AppTextStyles()
                                  .titleSmallTextStyle(context: context)
                                  ?.copyWith(
                                    fontWeight: AppFontWeight().semiBold,
                                  ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            final item = agendaItems[index];

            if (item.time.isEmpty || item.topic.isEmpty) {
              return const SizedBox();
            }
            return Divider(
              indent: 14,
              endIndent: 14,
              color: context.colorScheme.primary,
            );
          },
        ),
      ],
    );
  }
}
