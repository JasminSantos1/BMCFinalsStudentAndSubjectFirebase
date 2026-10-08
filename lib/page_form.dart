import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ==================== REUSABLE CAT DECORATION WIDGETS ====================

class CuteCatPainter extends CustomPainter {
  final Color catColor;
  final bool hasBlush;

  CuteCatPainter({required this.catColor, this.hasBlush = true});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = catColor
      ..style = PaintingStyle.fill;

    final outlinePaint = Paint()
      ..color = const Color(0xFF4A3E3D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final path = Path();
    // Base Cat Body & Ears
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.35);
    path.lineTo(size.width * 0.25, 0); // Left ear tip
    path.lineTo(size.width * 0.4, size.height * 0.2); // Head center dipped
    path.lineTo(size.width * 0.75, 0); // Right ear tip
    path.lineTo(size.width, size.height * 0.35);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, outlinePaint);

    // Eyes
    final eyePaint = Paint()
      ..color = const Color(0xFF4A3E3D)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width * 0.32, size.height * 0.45), 3, eyePaint);
    canvas.drawCircle(Offset(size.width * 0.68, size.height * 0.45), 3, eyePaint);

    // Mouth
    final mouthPath = Path();
    mouthPath.moveTo(size.width * 0.44, size.height * 0.58);
    mouthPath.quadraticBezierTo(
        size.width * 0.5, size.height * 0.65, size.width * 0.56, size.height * 0.58);
    canvas.drawPath(mouthPath, outlinePaint);

    // Blush
    if (hasBlush) {
      final blushPaint = Paint()
        ..color = const Color(0xFFFFB4A2).withOpacity(0.7)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(size.width * 0.22, size.height * 0.55), 4, blushPaint);
      canvas.drawCircle(Offset(size.width * 0.78, size.height * 0.55), 4, blushPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CatHeaderRow extends StatelessWidget {
  const CatHeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 40,
            height: 35,
            child: CustomPaint(painter: CuteCatPainter(catColor: const Color(0xFFA2D2FF))),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 35,
            height: 30,
            child: CustomPaint(painter: CuteCatPainter(catColor: const Color(0xFFFFC8DD))),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 45,
            height: 40,
            child: CustomPaint(painter: CuteCatPainter(catColor: const Color(0xFFFFE5EC))),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 35,
            height: 32,
            child: CustomPaint(painter: CuteCatPainter(catColor: const Color(0xFFBDE0FE))),
          ),
        ],
      ),
    );
  }
}

Widget buildCutePage({
  required int step,
  required String title,
  required Widget child,
}) {
  const kPeach = Color(0xFFFF8B52);
  const kCardBg = Color(0xFFFFFFFF);
  const kBorder = Color(0xFFFFE0D0);

  return Scaffold(
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: kPeach.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.pets_rounded, color: kPeach, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'STEP $step OF 3',
                      style: const TextStyle(
                        color: kPeach,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Progress Bars
                Row(
                  children: [
                    for (int i = 1; i <= 3; i++)
                      Expanded(
                        child: Container(
                          height: 6,
                          margin: EdgeInsets.only(right: i == 3 ? 0 : 6),
                          decoration: BoxDecoration(
                            color: i <= step ? kPeach : const Color(0xFFE2DED8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 18),

                // Title
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF4A3E3D),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 18),

                // Card Container
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: kCardBg,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: kBorder, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: child,
                ),
                const SizedBox(height: 16),

                const CatHeaderRow(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

// ==================== SCREEN 1: USER REGISTRATION ====================
class UserRegistrationScreen extends StatefulWidget {
  const UserRegistrationScreen({super.key});

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _sectionController = TextEditingController();
  final _courseController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _sectionController.dispose();
    _courseController.dispose();
    super.dispose();
  }

  void _next() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubjectEnrollmentScreen(
          name: _nameController.text.trim(),
          section: _sectionController.text.trim(),
          course: _courseController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildCutePage(
      step: 1,
      title: 'User Registration',
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Please enter your name' : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _sectionController,
              decoration: const InputDecoration(labelText: 'Section', hintText: 'e.g., 301'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Please enter your section' : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _courseController,
              decoration: const InputDecoration(labelText: 'Course', hintText: 'e.g., BSIT'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Please enter your course' : null,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _next,
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== SCREEN 2: SUBJECT ENROLLMENT ====================
class SubjectEnrollmentScreen extends StatefulWidget {
  final String name;
  final String section;
  final String course;

  const SubjectEnrollmentScreen({
    super.key,
    required this.name,
    required this.section,
    required this.course,
  });

  @override
  State<SubjectEnrollmentScreen> createState() => _SubjectEnrollmentScreenState();
}

class _SubjectEnrollmentScreenState extends State<SubjectEnrollmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subject1Controller = TextEditingController(text: 'BMC');
  final _time1Controller = TextEditingController(text: '7:30 - 10:30');

  final _subject2Controller = TextEditingController(text: 'AI');
  final _time2Controller = TextEditingController(text: '10:30 - 1:30');

  @override
  void dispose() {
    _subject1Controller.dispose();
    _time1Controller.dispose();
    _subject2Controller.dispose();
    _time2Controller.dispose();
    super.dispose();
  }

  void _next() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubjectVerificationScreen(
          name: widget.name,
          section: widget.section,
          course: widget.course,
          subjects: [
            {
              'subject': _subject1Controller.text.trim(),
              'time': _time1Controller.text.trim()
            },
            {
              'subject': _subject2Controller.text.trim(),
              'time': _time2Controller.text.trim()
            },
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 16,
            decoration: BoxDecoration(
              color: const Color(0xFFFF8B52),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A3E3D),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildCutePage(
      step: 2,
      title: 'Subject Enrollment',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('First Subject'),
            TextFormField(
              controller: _subject1Controller,
              decoration: const InputDecoration(labelText: 'Subject'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _time1Controller,
              decoration: const InputDecoration(labelText: 'Time', hintText: 'e.g., 7:30 - 10:30'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 18),
            _buildSectionHeader('Second Subject'),
            TextFormField(
              controller: _subject2Controller,
              decoration: const InputDecoration(labelText: 'Subject'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _time2Controller,
              decoration: const InputDecoration(labelText: 'Time', hintText: 'e.g., 10:30 - 1:30'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Back'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _next,
                    child: const Text('Next'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== SCREEN 3: SUBJECT VERIFICATION & FIRESTORE SAVE ====================
class SubjectVerificationScreen extends StatefulWidget {
  final String name;
  final String section;
  final String course;
  final List<Map<String, String>> subjects;

  const SubjectVerificationScreen({
    super.key,
    required this.name,
    required this.section,
    required this.course,
    required this.subjects,
  });

  @override
  State<SubjectVerificationScreen> createState() => _SubjectVerificationScreenState();
}

class _SubjectVerificationScreenState extends State<SubjectVerificationScreen> {
  bool _isSaving = false;

  Future<void> _saveToFirestore() async {
    setState(() => _isSaving = true);
    try {
      await FirebaseFirestore.instance.collection('registrations').add({
        'name': widget.name,
        'section': widget.section,
        'course': widget.course,
        'subjects': widget.subjects,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFFFFE0D0)),
          ),
          icon: const Icon(Icons.check_circle_rounded, color: Color(0xFFFF8B52), size: 48),
          title: const Text('Success!'),
          content: const Text(
            'Your enrollment was saved to Firestore.',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK', style: TextStyle(color: Color(0xFFFF8B52))),
            ),
          ],
        ),
      );

      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const UserRegistrationScreen()),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving data: $e')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(color: Color(0xFF9E8B88), fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF4A3E3D),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectCard(int index, Map<String, String> item) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9EE),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFFE0D0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Subject $index',
            style: const TextStyle(
              color: Color(0xFFFF8B52),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          _buildDetailRow('Subject', item['subject'] ?? ''),
          _buildDetailRow('Time', item['time'] ?? ''),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildCutePage(
      step: 3,
      title: 'Subject Verification',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Personal Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A3E3D),
            ),
          ),
          const SizedBox(height: 8),
          _buildDetailRow('Name', widget.name),
          _buildDetailRow('Section', widget.section),
          _buildDetailRow('Course', widget.course),
          const SizedBox(height: 16),
          const Text(
            'Enrolled Subjects',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A3E3D),
            ),
          ),
          const SizedBox(height: 10),
          ...widget.subjects.asMap().entries.map((entry) {
            return _buildSubjectCard(entry.key + 1, entry.value);
          }),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _isSaving ? null : () => Navigator.pop(context),
                  child: const Text('Back'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _saveToFirestore,
                  child: Text(_isSaving ? 'Saving...' : 'Save'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}