import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kSupportTeal = Color(0xFF76EAD0);
const Color kSupportBlue = Color(0xFF76D7EA);
const Color kSupportMain = Color(0xFF5DCFCF);
const Color kSupportScaffold = Color(0xFFF0F4F3);

class UserSupportScreen extends StatefulWidget {
  const UserSupportScreen({super.key});

  @override
  State<UserSupportScreen> createState() => _UserSupportScreenState();
}

class _UserSupportScreenState extends State<UserSupportScreen> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _helpKey = GlobalKey();
  final GlobalKey _privacyKey = GlobalKey();
  final GlobalKey _termsKey = GlobalKey();
  final GlobalKey _reportKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();

  final TextEditingController _issueTitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  PlatformFile? _selectedFile;

  @override
  void dispose() {
    _scrollController.dispose();
    _issueTitleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 550),
      curve: Curves.easeInOut,
      alignment: 0.05,
    );
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf'],
      allowMultiple: false,
    );

    if (result == null || result.files.isEmpty) return;

    final file = result.files.first;
    final sizeInMb = file.size / (1024 * 1024);

    if (sizeInMb > 5) {
      _showSnackBar('File size must be less than 5 MB.');
      return;
    }

    setState(() {
      _selectedFile = file;
    });
  }

  void _removeFile() {
    setState(() {
      _selectedFile = null;
    });
  }

  void _submitReport() {
    final title = _issueTitleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty || _selectedFile == null) {
      _showSnackBar('Please complete all fields before submitting the report.');
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 26, 24, 22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    color: kSupportTeal.withOpacity(0.22),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: kSupportMain,
                    size: 34,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Report Sent',
                  style: GoogleFonts.inter(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Your report has been submitted successfully. Our team will send a response to your email within 1x24 hours.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    height: 1.55,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _issueTitleController.clear();
                      _descriptionController.clear();
                      setState(() {
                        _selectedFile = null;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kSupportMain,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      'Okay',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.inter(fontSize: 13),
        ),
        backgroundColor: Colors.black87,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  String _formatFileSize(int bytes) {
    final mb = bytes / (1024 * 1024);
    if (mb >= 1) return '${mb.toStringAsFixed(2)} MB';

    final kb = bytes / 1024;
    return '${kb.toStringAsFixed(1)} KB';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSupportScaffold,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSupportTopics(),
                  const SizedBox(height: 16),
                  _buildHelpCenter(),
                  const SizedBox(height: 16),
                  _buildPrivacyPolicy(),
                  const SizedBox(height: 16),
                  _buildTermsOfService(),
                  const SizedBox(height: 16),
                  _buildReportProblem(),
                  const SizedBox(height: 16),
                  _buildAboutSproutly(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kSupportBlue, kSupportTeal],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Support & Info',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSupportTopics() {
    return _sectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Support Topics'),
          const SizedBox(height: 12),
          _topicItem(
            icon: Icons.help_outline_rounded,
            color: kSupportBlue,
            title: 'Help Center',
            onTap: () => _scrollToSection(_helpKey),
          ),
          _topicItem(
            icon: Icons.privacy_tip_outlined,
            color: kSupportTeal,
            title: 'Privacy Policy',
            onTap: () => _scrollToSection(_privacyKey),
          ),
          _topicItem(
            icon: Icons.description_outlined,
            color: const Color(0xFFD0FF99),
            title: 'Terms of Service',
            onTap: () => _scrollToSection(_termsKey),
          ),
          _topicItem(
            icon: Icons.flag_outlined,
            color: Colors.redAccent,
            title: 'Report a Problem',
            onTap: () => _scrollToSection(_reportKey),
          ),
          _topicItem(
            icon: Icons.eco_outlined,
            color: const Color(0xFF99CC66),
            title: 'About Sproutly',
            onTap: () => _scrollToSection(_aboutKey),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpCenter() {
    return Container(
      key: _helpKey,
      child: _sectionCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Help Center'),
            const SizedBox(height: 10),
            _paragraph(
              'Find answers to common questions and get help with using Sproutly. Our support team is here to assist you with consultations, payments, reports, and account settings.',
            ),
            const SizedBox(height: 12),
            _faqTile(
              title: 'How to start a consultation',
              answer:
                  'Open the consultation page, choose a plant expert based on your issue, review the expert profile, then start the consultation. Some experts may require payment before chat access is unlocked.',
            ),
            _faqTile(
              title: 'How to contact an expert',
              answer:
                  'You can contact an expert through the chat feature. You may send text messages, photos, or videos so the expert can understand your plant condition more clearly.',
            ),
            _faqTile(
              title: 'How payments work',
              answer:
                  'Payments are used to unlock expert consultation sessions. After payment is completed, your consultation access will be activated and the payment history will be saved in your account.',
            ),
            _faqTile(
              title: 'How to report plant issues',
              answer:
                  'Prepare a clear explanation of the issue, add a supporting screenshot or image, then submit the report through the Report a Problem section. Our team will review your report as soon as possible.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacyPolicy() {
    return Container(
      key: _privacyKey,
      child: _sectionCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Privacy Policy'),
            const SizedBox(height: 10),
            _paragraph(
              'We take your privacy seriously. This policy explains how Sproutly collects, uses, and protects your information while you use our services.',
            ),
            const SizedBox(height: 12),
            _subTitle('Data Usage'),
            _paragraph(
              'Sproutly collects information needed to provide plant consultation services, such as your name, email, consultation history, plant issue descriptions, uploaded photos, and payment status.',
            ),
            _subTitle('User Privacy Protection'),
            _paragraph(
              'Your personal information is not shared with third parties without your consent, except when required for service operations, security, or legal obligations.',
            ),
            _subTitle('Consultation Data'),
            _paragraph(
              'Messages, photos, and videos shared during consultations are used to help experts provide accurate plant care advice. This data is handled securely and only shown to relevant consultation parties.',
            ),
            _subTitle('Information Storage'),
            _paragraph(
              'Your account and consultation data are stored securely. You may request updates, corrections, or deletion of your personal data through the support section.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsOfService() {
    return Container(
      key: _termsKey,
      child: _sectionCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Terms of Service'),
            const SizedBox(height: 10),
            _paragraph(
              'By using Sproutly, you agree to follow these terms and use the platform responsibly.',
            ),
            const SizedBox(height: 12),
            _subTitle('User Responsibilities'),
            _paragraph(
              'Users must provide accurate information, respect expert time, avoid abusive language, and use consultation results as plant care guidance rather than guaranteed outcomes.',
            ),
            _subTitle('Expert Consultation'),
            _paragraph(
              'Experts provide advice based on the information, photos, or videos submitted by users. The accuracy of advice depends on the completeness and clarity of the information provided.',
            ),
            _subTitle('Payment Policy'),
            _paragraph(
              'Payments are processed through secure channels. Consultation access is provided after successful payment. Refunds may depend on cancellation status and platform review.',
            ),
            _subTitle('Platform Rules'),
            _paragraph(
              'Spam, harassment, misleading reports, inappropriate content, and misuse of the platform are not allowed. Sproutly may restrict accounts that violate community standards.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportProblem() {
    return Container(
      key: _reportKey,
      child: _sectionCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Report a Problem'),
            const SizedBox(height: 10),
            _paragraph(
              'Encountered an issue? Let us know and we will work to resolve it quickly.',
            ),
            const SizedBox(height: 14),
            Text(
              'Issue Title',
              style: _labelStyle(),
            ),
            const SizedBox(height: 6),
            _textField(
              controller: _issueTitleController,
              hint: 'Brief description of the issue',
              maxLines: 1,
            ),
            const SizedBox(height: 14),
            Text(
              'Description',
              style: _labelStyle(),
            ),
            const SizedBox(height: 6),
            _textField(
              controller: _descriptionController,
              hint:
                  'Please provide details about the problem you are experiencing...',
              maxLines: 5,
            ),
            const SizedBox(height: 14),
            Text(
              'Screenshot or Supporting File',
              style: _labelStyle(),
            ),
            const SizedBox(height: 6),
            _buildUploadBox(),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitReport,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kSupportMain,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'Submit Report',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSproutly() {
    return Container(
      key: _aboutKey,
      child: _sectionCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('About Sproutly'),
            const SizedBox(height: 10),
            _paragraph(
              'Sproutly is a digital platform that connects plant enthusiasts and farmers with expert botanists for consultation, education, and practical plant care guidance.',
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 10),
            _aboutRow('App Version', '1.0.0'),
            const SizedBox(height: 14),
            _aboutRow('Contact Email', 'support@sproutly.app'),
            const SizedBox(height: 22),
            Center(
              child: Text(
                '© 2026 Sproutly by AVI',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topicItem({
    required IconData icon,
    required Color color,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9),
        child: Row(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 12),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _faqTile({
    required String title,
    required String answer,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: kSupportScaffold,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 14),
          childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
          iconColor: Colors.grey.shade500,
          collapsedIconColor: Colors.grey.shade500,
          title: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                answer,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  height: 1.5,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadBox() {
    if (_selectedFile != null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: kSupportScaffold,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: kSupportMain.withOpacity(0.45)),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: kSupportTeal.withOpacity(0.22),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.insert_drive_file_outlined,
                color: kSupportMain,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _selectedFile!.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    _formatFileSize(_selectedFile!.size),
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: _removeFile,
              icon: const Icon(
                Icons.close_rounded,
                color: Colors.redAccent,
                size: 20,
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: _pickFile,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.grey.shade300,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.cloud_upload_outlined,
              color: Colors.grey.shade300,
              size: 34,
            ),
            const SizedBox(height: 8),
            Text(
              'Tap to upload file',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              'PNG, JPG, JPEG, or PDF up to 5 MB',
              style: GoogleFonts.inter(
                fontSize: 11,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    required int maxLines,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.inter(
        fontSize: 13,
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          fontSize: 13,
          color: Colors.grey.shade400,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 13,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: kSupportMain, width: 1.4),
        ),
      ),
    );
  }

  Widget _sectionCard({
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.045),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: Colors.black87,
      ),
    );
  }

  Widget _subTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w800,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _paragraph(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 12.5,
        height: 1.55,
        color: Colors.grey.shade600,
      ),
    );
  }

  Widget _aboutRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12.5,
            color: Colors.grey.shade600,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: kSupportMain,
          ),
        ),
      ],
    );
  }

  TextStyle _labelStyle() {
    return GoogleFonts.inter(
      fontSize: 12.5,
      fontWeight: FontWeight.w700,
      color: Colors.black87,
    );
  }
}
