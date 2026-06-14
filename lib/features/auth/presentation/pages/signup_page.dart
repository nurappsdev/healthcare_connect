import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';

/// The role a person selects when signing up.
enum SignupRole { lookingForWork, hiring, teaching }

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  SignupRole? _selectedRole = SignupRole.hiring;

  void _selectRole(SignupRole role) {
    setState(() => _selectedRole = role);
    context.push(AppRoutes.createAccount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              child: IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.chevron_left,
                  color: AppColors.whiteColor,
                  size: 28,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Are you looking for new Opportunities',
                    style: TextStyle(
                      color: AppColors.accentTeal,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 28),
                  _RoleCard(
                    title: 'Yes, I am actively looking for',
                    description:
                        'Get the opportunity to join the best company and '
                        'grow together as an employee.',
                    selected: _selectedRole == SignupRole.lookingForWork,
                    onTap: () => _selectRole(SignupRole.lookingForWork),
                  ),
                  const SizedBox(height: 12),
                  _RoleCard(
                    title: 'Im open job for seeking',
                    description:
                        'Choose the best candidate you want and grow big '
                        'together.',
                    selected: _selectedRole == SignupRole.hiring,
                    onTap: () => _selectRole(SignupRole.hiring),
                  ),
                  const SizedBox(height: 12),
                  _RoleCard(
                    title: 'Im open teaching',
                    description:
                        'Provide instruction based on your license or '
                        'anything needed.',
                    selected: _selectedRole == SignupRole.teaching,
                    onTap: () => _selectRole(SignupRole.teaching),
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

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.title,
    required this.description,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String description;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: selected ? AppColors.accentPurple : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: selected
              ? null
              : Border.all(color: AppColors.cardBorderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(
                color: AppColors.whiteColor,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
