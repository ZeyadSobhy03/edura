import 'dart:developer';

import 'package:edura/core/localization/error_messages.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/presentation/view_model/home_work/home_work_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../core/resources/routes/route_manger.dart';
import '../widgets/home_work_card.dart';

class HomeworkScreen extends StatefulWidget {
  const HomeworkScreen({super.key, this.lessonId});

  final String? lessonId;

  @override
  State<HomeworkScreen> createState() => _HomeworkScreenState();
}

class _HomeworkScreenState extends State<HomeworkScreen> {
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
    if (widget.lessonId == null) {
      context.read<HomeWorkCubit>().getAllHomeworks();
    } else {
      context.read<HomeWorkCubit>().fetchHomeworks(widget.lessonId!);
    }
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
          text: l10.homework,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorManager.black,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<HomeWorkCubit, HomeWorkState>(
          builder: (context, state) {
            log('HomeworkScreen: Current state: $state');
            if (state is HomeWorkLoading) {
              return const Center(
                child: CircularProgressIndicator(color: ColorManager.primary),
              );
            } else if (state is HomeWorkFailure) {
              return Center(
                child: Text(
                  ErrorMessages.get(context, state.error),
                  style: const TextStyle(
                    color: ColorManager.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else if (state is HomeWorkLoaded) {
              final homeworks = state.homeworks;
              if (homeworks.isEmpty) {
                return Center(
                  child: Text(
                    l10.noHomework,
                    style: TextStyle(
                      color: ColorManager.gray,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: homeworks.length,
                itemBuilder: (context, index) {
                  final homework = homeworks[index];

                  return HomeWorkCard(
                    key: ValueKey(homework.id),
                    homework: homework,
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}