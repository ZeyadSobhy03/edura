import 'package:edura/core/model/edit_profile_arguments.dart';
import 'package:edura/core/model/web_view_arguments.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/presentation/role/student/tabs/profile/presentation/view/section/settings/sections/profile_summary_card.dart';
import 'package:edura/presentation/role/student/tabs/profile/presentation/view/section/settings/sections/settings_group_card.dart';
import 'package:edura/presentation/role/student/tabs/profile/presentation/view/section/settings/sections/settings_section_header.dart';
import 'package:edura/presentation/role/student/tabs/profile/presentation/view/section/settings/widgets/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../../core/widgets/change_language_card.dart';
import '../../../../../../../../../l10n/app_localizations.dart';
import '../../../view_model/student_profile/student_profile_view_model.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? studentId;

  @override
  void initState() {
    super.initState();
    studentId = Supabase.instance.client.auth.currentUser?.id;

    if (studentId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, RouteManger.loginRoute);
        }
      });
      return;
    }

    context.read<StudentProfileCubit>().getStudentProfile(
      studentId: studentId!,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: l10.settings,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<StudentProfileCubit, StudentProfileState>(
                builder: (context, state) {
                  if (state is StudentProfileLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.primary,
                      ),
                    );
                  }
                  if (state is StudentProfileError) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(state.message, textAlign: TextAlign.center),
                          TextButton(
                            onPressed: () {
                              if (studentId == null) return;
                              context
                                  .read<StudentProfileCubit>()
                                  .getStudentProfile(studentId: studentId!);
                            },
                            child: Text(l10.retry),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is StudentProfileLoaded) {
                    final student = state.student;
                    return ProfileSummaryCard(
                      name: student.name,
                      phone: student.phone,
                      onTap: () async {
                        final cubit = context.read<StudentProfileCubit>();
                        await Navigator.pushNamed(
                          context,
                          RouteManger.editProfileScreen,
                          arguments: EditProfileArguments(
                            studentId: student.id,
                            phone: student.phone,
                            currentName: student.name,
                          ),
                        );
                        if (!mounted || studentId == null) return;
                        cubit.getStudentProfile(studentId: studentId!);
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),

              const SizedBox(height: 20),

              SettingsSectionHeader(title: l10.preferences),
              ChangeLanguageCard(),
              const SizedBox(height: 20),

              SettingsSectionHeader(title: l10.account),
              SettingsGroupCard(
                children: [
                  SettingsTile(
                    icon: Icons.lock_outline,
                    title: l10.changePassword,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteManger.changePasswordScreen,
                      );
                    },
                  ),
                  SettingsTile(
                    icon: Icons.privacy_tip_outlined,
                    title: l10.privacyPolicy,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteManger.webViewScreen,
                        arguments: WebViewArguments(
                          url: 'https://yourapp.com/privacy-policy',
                          title: l10.privacyPolicy,
                        ),
                      );
                    },
                  ),
                  SettingsTile(
                    icon: Icons.description_outlined,
                    title: l10.termsOfService,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteManger.webViewScreen,
                        arguments: WebViewArguments(
                          url: 'https://yourapp.com/terms-of-service',
                          title: l10.termsOfService,
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              SettingsSectionHeader(title: l10.support),
              SettingsGroupCard(
                children: [
                  SettingsTile(
                    icon: Icons.help_outline,
                    title: l10.helpCenter,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteManger.helpAndFaqScreen,
                      );
                    },
                  ),
                  SettingsTile(
                    icon: Icons.chat_bubble_outline,
                    title: l10.contactSupport,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteManger.getSupportScreen,
                      );
                    },
                  ),
                  SettingsTile(
                    icon: Icons.info_outline,
                    title: l10.about,
                    trailingText: 'v1.0.0',
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
