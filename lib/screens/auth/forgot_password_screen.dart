import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app_widgets.dart';
import '../../app_colors.dart';
import 'input_password_baru.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  String? emailError;
  bool showPopup = false;

  bool isValidEmail(String email) {
    return RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(email);
  }

  void handleResetPassword() {
    final email = emailController.text.trim();

    setState(() {
    if (email.isEmpty || !isValidEmail(email)) {
      emailError = 'Username incorrect';
    } else {
      emailError = null;
    }
  });

  if (emailError != null) return;
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const ResetPasswordScreen(),
    ),
  ); 
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      const BackButtonWidget(),
                      const SizedBox(width: 8),
                      if (showPopup)
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 18,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE1E5EA),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFF9CA3AF),
                              ),
                            ),
                            child: Text(
                              'We have sent an e-mail to you for verification. Follow the link provided to reset your password',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.outfit(
                                fontSize: 10,
                                color: AppColors.textDark,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppColors.splashGradient,
                      ),
                      child: const Icon(
                        Icons.lock_rounded,
                        color: Colors.white,
                        size: 34,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Center(
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.outfit(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Center(
                    child: Text(
                      'Enter your email to receive a reset link',
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  AppTextField(
                    label: 'Email',
                    hint: 'user123@gmail.com',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    errorText: emailError,
                  ),

                  const SizedBox(height: 24),

                  PrimaryButton(
                    text: 'Send Reset Link',
                    onPressed: handleResetPassword,
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