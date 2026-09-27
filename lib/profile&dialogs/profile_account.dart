import 'package:flutter/material.dart';
import 'logout_confirmation.dart';

class ProfileAccount extends StatelessWidget {
  const ProfileAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Account',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF182033),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Admin Profile Settings',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF687386),
                          ),
                        ),
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFE1E6EF),
                        ),
                      ),
                      child: const Icon(
                        Icons.chevron_left,
                        color: Color(0xFF526071),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 35),

              // Profile
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 96,
                      width: 96,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2864E8),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          'SK',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    const Text(
                      'Sahil Kumar',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF182033),
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      'sahil@admin.com',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF687386),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              _accountItem(
                icon: Icons.person_outline,
                title: 'Edit Profile',
                onTap: () {},
              ),

              const SizedBox(height: 12),

              _accountItem(
                icon: Icons.lock_outline,
                title: 'Change Password',
                onTap: () {},
              ),

              const SizedBox(height: 12),

              _accountItem(
                icon: Icons.logout_rounded,
                title: 'Logout',
                isLogout: true,
                onTap: () {
                  showLogoutConfirmation(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _accountItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xFFE2E7EF),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 38,
              width: 38,
              decoration: BoxDecoration(
                color: isLogout
                    ? const Color(0xFFFFEEEE)
                    : const Color(0xFFEAF1FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 21,
                color: isLogout
                    ? const Color(0xFFFF3B3B)
                    : const Color(0xFF2864E8),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isLogout
                      ? const Color(0xFFFF3B3B)
                      : const Color(0xFF202A3A),
                ),
              ),
            ),

            Icon(
              Icons.chevron_right,
              color: isLogout
                  ? const Color(0xFFFF3B3B)
                  : const Color(0xFF9AA4B2),
            ),
          ],
        ),
      ),
    );
  }
}