import 'package:event_app/core/localization/l10n/l10n.dart';
import 'package:event_app/features/ask_question/data/models/request_model/ask_question_request_model.dart';
import 'package:event_app/features/ask_question/presentation/manager/ask_question_bloc/ask_question_bloc.dart';
import 'package:event_app/features/auth/presentation/widget/auth_validation.dart';
import 'package:event_app/features/speakers/presentation/manager/speaker_bloc/speaker_bloc.dart';
import 'package:event_app/utils/common/app_button.dart';
import 'package:event_app/utils/common/app_drawer_widget.dart';
import 'package:event_app/utils/common/app_drop_down.dart';
import 'package:event_app/utils/common/app_header_widget.dart';
import 'package:event_app/utils/common/app_text_field.dart';
import 'package:event_app/utils/common/common_app_bar.dart';
import 'package:event_app/utils/common/fade_animation.dart';
import 'package:event_app/utils/constants/app_const.dart';
import 'package:event_app/utils/constants/app_snack_bar.dart';
import 'package:event_app/utils/di/di_container.dart';
import 'package:event_app/utils/navigation/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AskQuestionScreen extends StatefulWidget {
  const AskQuestionScreen({super.key});

  @override
  State<AskQuestionScreen> createState() => _AskQuestionScreenState();
}

class _AskQuestionScreenState extends State<AskQuestionScreen> {
  final formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final selectedSession = ValueNotifier<String?>(null);
  final youNameController = TextEditingController();
  final askQuestionController = TextEditingController();
  late SpeakerBloc speakerBloc;
  late AskQuestionBloc askQuestionBloc;

  @override
  void initState() {
    super.initState();
    speakerBloc = di.get<SpeakerBloc>();
    speakerBloc.add(FetchSpeakers());
    askQuestionBloc = di.get<AskQuestionBloc>();
  }

  @override
  void dispose() {
    selectedSession.dispose();
    youNameController.dispose();
    askQuestionController.dispose();
    speakerBloc.close();
    askQuestionBloc.close();
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
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppConst().screenHorizontalPadding,
          ),
          child: Column(
            children: [
              AppHeaderWidget(title: context.l10n.ask_question),
              _fields(context),
              _submitButton(context),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return BlocProvider.value(
      value: askQuestionBloc,
      child: BlocConsumer<AskQuestionBloc, AskQuestionState>(
        listener: (BuildContext context, state) {
          if (state is AskQuestionErrorState) {
            AppSnackBar().showErrorSnackBar(
              context: context,
              errorMessage: state.errorMessage,
            );
          }

          if (state is AskQuestionLoadedState) {
            AppSnackBar().showSuccessSnackBar(
              context: context,
              successMessage: 'Request Submitted Successfully',
            );
            AppNavigation().navigateBack(context: context);
          }
        },
        builder: (context, state) {
          return FadeAnimation(
            delay: 1,
            beginPointOnY: 30,
            child: AppButton(
              text: context.l10n.submit,
              isLoading: state is AskQuestionLoadingState,
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  askQuestionBloc.add(
                    SubmitQuestionEvent(
                      requestModel: AskQuestionRequestModel(
                        eventId: 1,
                        speakerName: selectedSession.value.toString(),
                        askedBy: youNameController.text,
                        questionDetail: askQuestionController.text,
                      ),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _fields(BuildContext context) {
    return Form(
      key: formkey,
      child: FadeAnimation(
        delay: 1,
        child: Column(
          children: [
            const SizedBox(height: 35),
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
                    return ValueListenableBuilder<String?>(
                      valueListenable: selectedSession,
                      builder: (context, value, child) {
                        return AppDropdown<String>(
                          items: state.speakerList
                              .map((e) => e.speakerName)
                              .toList(),
                          selectedValue: value,
                          title: context.l10n.select_session,
                          hintText: context.l10n.select_session_hint,
                          onChanged: (newValue) {
                            selectedSession.value = newValue;
                          },
                          validator: (v) {
                            return AuthValidation().validateSession(v, context);
                          },
                        );
                      },
                    );
                  }
                  return const Text('Error Occurred');
                },
              ),
            ),
            const SizedBox(height: 20),
            AppTextField(
              controller: youNameController,
              title: context.l10n.your_name,
              hintText: context.l10n.your_name_hint,
              validator: (v) {
                return AuthValidation().validateYourName(v, context);
              },
            ),
            const SizedBox(height: 20),
            AppTextField(
              controller: askQuestionController,
              title: context.l10n.ask_question_field,
              hintText: context.l10n.ask_question_field_hint,
              maxlines: 6,
              validator: (v) {
                return AuthValidation().validateAskQuestion(v, context);
              },
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
