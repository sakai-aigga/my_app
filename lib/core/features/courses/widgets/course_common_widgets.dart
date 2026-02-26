import 'package:flutter/material.dart';
import 'package:my_app/core/constants.dart';

class Section extends StatelessWidget {
  final String title;
  final Widget child;
  const Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}

class BulletedList extends StatelessWidget {
  final List<String> items;

  const BulletedList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('•  ', style: TextStyle(color: AppColors.greyDark)),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(color: AppColors.greyDark),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
class MetaRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const MetaRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.greyShade1),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: AppColors.greyShade1),
          ),
        ),
      ],
    );
  }
}