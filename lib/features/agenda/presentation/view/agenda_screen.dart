import 'package:event_app/core/localization/l10n/l10n.dart';
import 'package:event_app/features/agenda/data/models/agenda_model.dart';
import 'package:event_app/features/agenda/presentation/manager/agenda_bloc/agenda_bloc.dart';
import 'package:event_app/features/agenda/presentation/widget/agenda_listing.dart';
import 'package:event_app/utils/common/app_drawer_widget.dart';
import 'package:event_app/utils/common/app_header_widget.dart';
import 'package:event_app/utils/common/common_app_bar.dart';
import 'package:event_app/utils/di/di_container.dart';
import 'package:event_app/utils/extension/context_extension.dart';
import 'package:event_app/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late AgendaBloc agendaBloc;
  int selectedDay = 1;
  Map<int, String> dayTitles = {};

  @override
  void initState() {
    super.initState();
    agendaBloc = di.get<AgendaBloc>();
    agendaBloc.add(FetchAgenda());
  }

  @override
  void dispose() {
    agendaBloc.close();
    super.dispose();
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
            AppHeaderWidget(title: context.l10n.agenda),
            const SizedBox(height: 20),
            BlocProvider.value(
              value: agendaBloc,
              child: BlocBuilder<AgendaBloc, AgendaState>(
                builder: (context, state) {
                  if (state is AgendaLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is AgendaErrorState) {
                    return Text(state.errorMessage);
                  }

                  if (state is AgendaLoadedState) {
                    final groupedAgenda = _groupAgendaByDay(state.agendaList);
                    final days = groupedAgenda.keys.toList()..sort();

                    return Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: days.map((day) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: ChoiceChip(
                                  side: BorderSide(
                                    color: selectedDay == day
                                        ? Colors.transparent
                                        : context.colorScheme.primary,
                                  ),
                                  label: Container(
                                    constraints:
                                        const BoxConstraints(maxWidth: 120),
                                    child: Text(
                                      'Day $day - ${dayTitles[day] ?? ""}',
                                      maxLines: 2,
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                      style:
                                          AppTextStyles().labelLargeTextStyle(
                                        context: context,
                                        textColor: selectedDay == day
                                            ? context.colorScheme.onPrimary
                                            : context.colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                  selected: selectedDay == day,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 25,
                                  ),
                                  showCheckmark: false,
                                  onSelected: (selected) {
                                    setState(() {
                                      selectedDay = day;
                                    });
                                  },
                                  selectedColor: context.colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        AgendaListing(
                          agendaItems: groupedAgenda[selectedDay] ?? [],
                        ),
                      ],
                    );
                  }

                  return const Text('Error Occurred');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Agenda Title and Day
  Map<int, List<AgendaModel>> _groupAgendaByDay(List<AgendaModel> agendaList) {
    final groupedAgenda = <int, List<AgendaModel>>{};
    for (final item in agendaList) {
      final day = int.tryParse(item.day.trim());

      if (day != null) {
        groupedAgenda.putIfAbsent(day, () => []).add(item);
        dayTitles[day] = item.title;
      }
    }
    return groupedAgenda;
  }
}
