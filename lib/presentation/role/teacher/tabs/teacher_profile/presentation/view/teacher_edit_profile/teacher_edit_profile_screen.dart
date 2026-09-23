import 'package:edura/core/extensions/text_ex.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/presentation/view/teacher_edit_profile/section/teacher_edit_profile_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/model/teacher_profile_model.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../view_model/teacher_profile_view_model.dart';

class TeacherEditProfileScreen extends StatefulWidget {
  const TeacherEditProfileScreen({super.key, required this.teacher});

  final TeacherProfileModel teacher;

  @override
  State<TeacherEditProfileScreen> createState() =>
      _TeacherEditProfileScreenState();
}

class _TeacherEditProfileScreenState extends State<TeacherEditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _subjectController;
  late final TextEditingController _yearsController;
  late final TextEditingController _bioController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.teacher.name);
    _subjectController = TextEditingController(text: widget.teacher.subject);
    _yearsController = TextEditingController(
      text: '${widget.teacher.yearsExperience}',
    );
    _bioController = TextEditingController(text: widget.teacher.bio);
    _phoneController = TextEditingController(text: widget.teacher.phone);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _subjectController.dispose();
    _yearsController.dispose();
    _bioController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _save() {
    final l10 = AppLocalizations.of(context)!;

    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10.nameRequired)));
      return;
    }
    if (_subjectController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10.subjectRequired)));
      return;
    }

    final teacherId = Supabase.instance.client.auth.currentUser!.id;

    context.read<TeacherProfileCubit>().updateTeacherProfile(
      teacherId: teacherId,
      name: _nameController.text.trim(),
      subject: _subjectController.text.trim(),
      bio: _bioController.text.trim(),
      phone: _phoneController.text.trim(),
      yearsExperience:
          int.tryParse(_yearsController.text.trim()) ??
          widget.teacher.yearsExperience,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return BlocListener<TeacherProfileCubit, TeacherProfileState>(
      listener: (context, state) {
        if (state is TeacherProfileLoaded) {
          Fluttertoast.showToast(
            msg: l10.profileUpdateSuccessfully,
            backgroundColor: ColorManager.green,
            gravity: ToastGravity.BOTTOM,
            textColor: ColorManager.white,
          );
          Navigator.pop(context, state.profile);
        } else if (state is TeacherProfileError) {
          Fluttertoast.showToast(
            msg: state.message,
            backgroundColor: ColorManager.red,
            gravity: ToastGravity.BOTTOM,
            textColor: ColorManager.white,
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: 0,
          centerTitle: true,
          title: CustomText(
            text: l10.editProfile,
            style: TextStyle(
              color: ColorManager.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 44,
                    backgroundColor: ColorManager.primary.withValues(
                      alpha: 0.1,
                    ),
                    child: CustomText(
                      text: _nameController.text.initials,
                      style: TextStyle(
                        color: ColorManager.primary,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                TeacherEditProfileBody(
                  nameController: _nameController,
                  subjectController: _subjectController,
                  yearsController: _yearsController,
                  bioController: _bioController,
                  phoneController: _phoneController,
                ),

                BlocBuilder<TeacherProfileCubit, TeacherProfileState>(
                  builder: (context, state) {
                    final isSaving = state is TeacherProfileUpdating;
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isSaving ? null : _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isSaving
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                l10.save,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
