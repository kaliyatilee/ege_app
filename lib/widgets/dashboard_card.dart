 import 'package:flutter/material.dart';
 Widget buildDashboardCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required String routeName,
  }) {
    return Card(
      color: color,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48.0, color: Colors.white),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  } 