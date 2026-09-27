import 'package:flutter/material.dart';
import 'all_students_admin.dart';
import 'add_student_admin.dart';
import '/profile&dialogs/profile_account.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  // ============================================================
  // MY ACCOUNT
  // ============================================================

  void _openProfileAccount(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileAccount(),
      ),
    );
  }

  // ============================================================
  // ADD STUDENT
  // ============================================================

  Future<void> _openAddStudent(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddStudentAdminScreen(),
      ),
    );
  }

  // ============================================================
  // VIEW ALL STUDENTS
  // ============================================================

  void _openAllStudents(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AllStudentsAdminScreen(),
      ),
    );
  }

  // ============================================================
  // FILTER STUDENTS
  // ============================================================

  void _openFilterStudents(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AllStudentsAdminScreen(
          openFilterAutomatically: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ==================================================
              // HEADER
              // ==================================================

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [

                      Text(
                        'Good Morning, Sahil',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111827),
                          letterSpacing: -0.5,
                        ),
                      ),

                      SizedBox(height: 5),

                      Text(
                        'Manage your students',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),

                  // ==================================================
                  // PROFILE BUTTON
                  // ==================================================

                  GestureDetector(
                    onTap: () {
                      _openProfileAccount(context);
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2563EB),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'SK',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ==================================================
              // STAT CARDS - ROW 1
              // ==================================================

              Row(
                children: [

                  Expanded(
                    child: _statCard(
                      icon: Icons.groups_outlined,
                      iconColor: const Color(0xFF2563EB),
                      iconBackground: const Color(0xFFEFF6FF),
                      number: '120',
                      title: 'Total Students',
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _statCard(
                      icon: Icons.person_add_alt_1_outlined,
                      iconColor: const Color(0xFF16A34A),
                      iconBackground: const Color(0xFFF0FDF4),
                      number: '12',
                      title: 'New Students',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // ==================================================
              // STAT CARDS - ROW 2
              // ==================================================

              Row(
                children: [

                  Expanded(
                    child: _statCard(
                      icon: Icons.sync,
                      iconColor: const Color(0xFFD97706),
                      iconBackground: const Color(0xFFFFFBEB),
                      number: '8',
                      title: 'Updated Today',
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _statCard(
                      icon: Icons.menu_book_outlined,
                      iconColor: const Color(0xFF7C3AED),
                      iconBackground: const Color(0xFFF5F3FF),
                      number: '6',
                      title: 'Active Classes',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ==================================================
              // QUICK ACTIONS
              // ==================================================

              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                ),
              ),

              const SizedBox(height: 14),

              Row(
                children: [

                  // ==================================================
                  // ADD STUDENT
                  // ==================================================

                  Expanded(
                    child: _quickAction(
                      icon: Icons.person_add_alt_1,
                      title: 'Add Student',
                      selected: true,
                      onTap: () {
                        _openAddStudent(context);
                      },
                    ),
                  ),

                  const SizedBox(width: 12),

                  // ==================================================
                  // VIEW ALL
                  // ==================================================

                  Expanded(
                    child: _quickAction(
                      icon: Icons.groups_outlined,
                      title: 'View All',
                      onTap: () {
                        _openAllStudents(context);
                      },
                    ),
                  ),

                  const SizedBox(width: 12),

                  // ==================================================
                  // FILTER LIST
                  // ==================================================

                  Expanded(
                    child: _quickAction(
                      icon: Icons.tune,
                      title: 'Filter List',
                      onTap: () {
                        _openFilterStudents(context);
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ==================================================
              // RECENT STUDENTS
              // ==================================================

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  const Text(
                    'Recent Students',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111827),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      _openAllStudents(context);
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        color: Color(0xFF2563EB),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // ==================================================
              // STUDENT 1
              // ==================================================

              _studentCard(
                initials: 'RK',
                name: 'Rahul Kumar',
                className: 'Class 12',
                email: 'rahul@gmail.com',
              ),

              const SizedBox(height: 10),

              // ==================================================
              // STUDENT 2
              // ==================================================

              _studentCard(
                initials: 'AS',
                name: 'Aditi Sharma',
                className: 'Class 11',
                email: 'aditi@gmail.com',
              ),

              const SizedBox(height: 10),

              // ==================================================
              // STUDENT 3
              // ==================================================

              _studentCard(
                initials: 'PP',
                name: 'Priya Patel',
                className: 'Class 12',
                email: 'priya@gmail.com',
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // STAT CARD
  // ============================================================

  static Widget _statCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required String number,
    required String title,
  }) {
    return Container(
      height: 125,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),

          const Spacer(),

          Text(
            number,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111827),
            ),
          ),

          const SizedBox(height: 2),

          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // QUICK ACTION
  // ============================================================

  static Widget _quickAction({
    required IconData icon,
    required String title,
    bool selected = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 82,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 13,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF2563EB)
              : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: selected
                ? const Color(0xFF2563EB)
                : const Color(0xFFE2E8F0),
          ),
          boxShadow: selected
              ? const [
                  BoxShadow(
                    color: Color(0x332563EB),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Icon(
              icon,
              size: 21,
              color: selected
                  ? Colors.white
                  : const Color(0xFF2563EB),
            ),

            const Spacer(),

            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: selected
                    ? Colors.white
                    : const Color(0xFF1E293B),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // STUDENT CARD
  // ============================================================

  static Widget _studentCard({
    required String initials,
    required String name,
    required String className,
    required String email,
  }) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        children: [

          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFEFF6FF),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              initials,
              style: const TextStyle(
                color: Color(0xFF2563EB),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Student details
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  '$className • $email',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.more_vert,
            color: Color(0xFF64748B),
            size: 21,
          ),
        ],
      ),
    );
  }
}