import 'package:event_app/core/localization/l10n/l10n.dart';
import 'package:event_app/features/speakers/presentation/manager/speaker_bloc/speaker_bloc.dart';
import 'package:event_app/features/speakers/presentation/widget/speaker_list_tile.dart';
import 'package:event_app/utils/common/app_drawer_widget.dart';
import 'package:event_app/utils/common/app_header_widget.dart';
import 'package:event_app/utils/common/common_app_bar.dart';
import 'package:event_app/utils/common/fade_animation.dart';
import 'package:event_app/utils/di/di_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpeakerListingScreen extends StatefulWidget {
  const SpeakerListingScreen({super.key});

  @override
  State<SpeakerListingScreen> createState() => _SpeakerListingScreenState();
}

class _SpeakerListingScreenState extends State<SpeakerListingScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late SpeakerBloc speakerBloc;

  @override
  void initState() {
    super.initState();
    speakerBloc = di.get<SpeakerBloc>();
    speakerBloc.add(FetchSpeakers());
  }

  @override
  void dispose() {
    speakerBloc.close();
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
            AppHeaderWidget(title: context.l10n.speakers),
            const SizedBox(height: 15),
            BlocProvider.value(
              value: speakerBloc,
              child: BlocBuilder<SpeakerBloc, SpeakerState>(
                builder: (context, state) {
                  if (state is SpeakerLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is SpeakerErrorState) {
                    return Text(state.errorMessage);
                  }
                  if (state is SpeakerLoadedState) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.speakerList.length,
                      itemBuilder: (context, index) {
                        final item = state.speakerList[index];
                        return FadePositionAnimation(
                          delay: index.toDouble(),
                          child: SpeakerListTile(speakerModel: item),
                        );
                      },
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
}
