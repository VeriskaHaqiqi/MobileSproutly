import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app_colors.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  bool get hasMinLength => _newPasswordController.text.length >= 8;

  bool get hasUpperAndLower {
    final text = _newPasswordController.text;
    return RegExp(r'[A-Z]').hasMatch(text) && RegExp(r'[a-z]').hasMatch(text);
  }

  bool get hasNumber {
    return RegExp(r'[0-9]').hasMatch(_newPasswordController.text);
  }

  bool get isPasswordValid => hasMinLength && hasUpperAndLower && hasNumber;

  bool get isConfirmMatch {
    return _confirmPasswordController.text == _newPasswordController.text &&
        _confirmPasswordController.text.isNotEmpty;
  }

  bool get canSubmit => isPasswordValid && isConfirmMatch;

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(() {
      setState(() {});
    });
    _confirmPasswordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _saveNewPassword() {
    if (!canSubmit) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password berhasil diperbarui'),
      ),
    );

    Navigator.pop(context);
  }

  Widget _requirementItem({
    required String text,
    required bool isChecked,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 19,
            height: 19,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isChecked ? AppColors.teal : Colors.transparent,
              border: Border.all(
                color: isChecked ? AppColors.teal : const Color(0xFFCBD5E1),
                width: 1.5,
              ),
            ),
            child: Icon(
              Icons.check,
              size: 13,
              color: isChecked ? Colors.white : const Color(0xFFCBD5E1),
            ),
          ),
          const SizedBox(width: 14),
          Text(
            text,
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: const Color(0xFF475569),
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback onEyeTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          obscureText: obscureText,
          style: GoogleFonts.outfit(
            fontSize: 14,
            color: AppColors.textDark,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.outfit(
              fontSize: 14,
              color: const Color(0xFF9CA3AF),
            ),
            suffixIcon: GestureDetector(
              onTap: onEyeTap,
              child: Icon(
                obscureText
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: const Color(0xFF94A3B8),
              ),
            ),
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.borderColor,
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.borderColor,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.teal,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 54,
              width: double.infinity,
              color: AppColors.teal,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 16,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.textDark,
                        size: 24,
                      ),
                    ),
                  ),
                  Text(
                    'Set New Password',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 36, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create New Password',
                      style: GoogleFonts.outfit(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 12),

                    Text(
                      'Your new password must be different from your\nprevious password.',
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        height: 1.6,
                        color: const Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(height: 28),

                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7FFFE),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFCCF4EE),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          _passwordField(
                            label: 'New Password',
                            hint: 'Enter new password',
                            controller: _newPasswordController,
                            obscureText: _obscureNewPassword,
                            onEyeTap: () {
                              setState(() {
                                _obscureNewPassword = !_obscureNewPassword;
                              });
                            },
                          ),
                          const SizedBox(height: 22),
                          _passwordField(
                            label: 'Confirm New Password',
                            hint: 'Re-enter new password',
                            controller: _confirmPasswordController,
                            obscureText: _obscureConfirmPassword,
                            onEyeTap: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    Text(
                      'Password Requirements',
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 16),

                    _requirementItem(
                      text: 'At least 8 characters',
                      isChecked: hasMinLength,
                    ),
                    _requirementItem(
                      text: 'Include uppercase and lowercase letters',
                      isChecked: hasUpperAndLower,
                    ),
                    _requirementItem(
                      text: 'Include at least one number',
                      isChecked: hasNumber,
                    ),

                    const SizedBox(height: 22),

                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: canSubmit
                              ? AppColors.primaryGradient
                              : const LinearGradient(
                                  colors: [
                                    Color(0xFFB9F3E7),
                                    Color(0xFFAEEAF5),
                                  ],
                                ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: TextButton(
                          onPressed: canSubmit ? _saveNewPassword : null,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text(
                            'Save New Password',
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: canSubmit
                                  ? AppColors.white
                                  : const Color(0xFF8B98A5),
                            ),
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