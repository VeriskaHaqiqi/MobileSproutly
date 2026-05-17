import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app_colors.dart';
import '../../app_widgets.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';
import '../user/user_home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  String? _emailError;
  String? _passError;

  bool isValidGmail(String email) {
    return RegExp(r'^[\w\.-]+@gmail\.com$').hasMatch(email);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _push(Widget screen) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (_, __, ___) => screen,
      transitionsBuilder: (_, animation, __, child) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          ),
          child: child,
        ),
      ),
      transitionDuration: const Duration(milliseconds: 350),
    ));
  }

  void _pushReplacement(Widget screen) {
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (_, __, ___) => screen,
      transitionsBuilder: (_, animation, __, child) =>
          FadeTransition(opacity: animation, child: child),
      transitionDuration: const Duration(milliseconds: 400),
    ));
  }

  void _handleLogin() {
    final email = _emailController.text.trim();
    final password = _passController.text.trim();

    setState(() {
      if (email.isEmpty) {
        _emailError = 'Email is required';
      } else if (!isValidGmail(email)) {
        _emailError = 'Please use a @gmail.com address';
      } else {
        _emailError = null;
      }
      _passError = password.isEmpty ? 'Password is required' : null;
    });

    if (_emailError != null || _passError != null) return;

    _pushReplacement(const HomeUserScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Logo: background tosca penuh, icon putih ──
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFF5DCFCF),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF5DCFCF).withOpacity(0.4),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 35,
                    height: 35,
                    fit: BoxFit.contain,
                    color: Colors.white,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.eco_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ── Heading ──
              Text(
                'Welcome Back',
                style: GoogleFonts.outfit(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 6),

              Text(
                'Log in to continue your plant journey',
                style: GoogleFonts.outfit(
                  fontSize: 13.5,
                  color: AppColors.textGrey,
                ),
              ),
              const SizedBox(height: 30),

              // ── Email Field ──
              AppTextField(
                label: 'Email',
                hint: 'your@gmail.com',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                errorText: _emailError,
              ),
              const SizedBox(height: 16),

              // ── Password Field ──
              AppTextField(
                label: 'Password',
                hint: '••••••••',
                controller: _passController,
                obscureText: true,
                errorText: _passError,
              ),
              const SizedBox(height: 10),

              // ── Forgot Password ──
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => _push(const ForgotPasswordScreen()),
                  child: Text(
                    'Forgot Password?',
                    style: GoogleFonts.outfit(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.tealDark,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // ── Log In Button ──
              PrimaryButton(
                text: 'Log In',
                onPressed: _handleLogin,
              ),
              const SizedBox(height: 20),

              // ── Divider ──
              Row(
                children: [
                  const Expanded(child: Divider(color: AppColors.borderColor)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'or continue with',
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(color: AppColors.borderColor)),
                ],
              ),
              const SizedBox(height: 14),

              // ── Google Button ──
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _handleLogin,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(
                        color: AppColors.borderColor, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: AppColors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Google "G" logo dengan warna resmi
                      SizedBox(
                        width: 22,
                        height: 22,
                        child: CustomPaint(painter: _GoogleGPainter()),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Continue with Google',
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // ── Register Link ──
              Center(
                child: Column(
                  children: [
                    Text(
                      "Don't have an account?",
                      style: GoogleFonts.outfit(
                        fontSize: 13.5,
                        color: AppColors.textGrey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () => _push(const RegisterScreen()),
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.outfit(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.tealDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Google "G" CustomPainter ─────────────────────────────────────────────────
// Warna resmi: Biru #4285F4 · Merah #EA4335 · Kuning #FBBC05 · Hijau #34A853
class _GoogleGPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2;
    final sw = size.width * 0.22;
    final hs = sw / 2;

    final p = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = sw
      ..strokeCap = StrokeCap.butt;

    // Merah — kiri atas
    p.color = const Color(0xFFEA4335);
    canvas.drawArc(Rect.fromCircle(center: Offset(cx, cy), radius: r - hs),
        _r(225), _r(45), false, p);

    // Kuning — bawah
    p.color = const Color(0xFFFBBC05);
    canvas.drawArc(Rect.fromCircle(center: Offset(cx, cy), radius: r - hs),
        _r(270), _r(90), false, p);

    // Hijau — kanan bawah
    p.color = const Color(0xFF34A853);
    canvas.drawArc(Rect.fromCircle(center: Offset(cx, cy), radius: r - hs),
        _r(0), _r(90), false, p);

    // Biru — kanan atas ke kiri
    p.color = const Color(0xFF4285F4);
    canvas.drawArc(Rect.fromCircle(center: Offset(cx, cy), radius: r - hs),
        _r(90), _r(135), false, p);

    // Bar horizontal biru
    canvas.drawRect(
      Rect.fromLTRB(cx, cy - hs / 2, size.width, cy + hs / 2),
      Paint()
        ..color = const Color(0xFF4285F4)
        ..style = PaintingStyle.fill,
    );
  }

  double _r(double deg) => deg * 3.14159265358979 / 180;

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}
