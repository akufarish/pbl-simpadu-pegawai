import 'package:flutter/material.dart';
import 'package:pegawai/models/sesi.dart';
import 'package:pegawai/utils/app_colors.dart';

// SesiCard yang sudah disesuaikan agar cocok dimasukkan ke list
class SesiCard extends StatelessWidget {
  final Sesi dataSesi;
  const SesiCard({super.key, required this.dataSesi});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
      ), // Beri jarak antar item
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  dataSesi.courseName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                _buildInfoRow(
                  Icons.access_time_filled_rounded,
                  "${dataSesi.startTime} - ${dataSesi.endTime} WITA",
                ),
                const SizedBox(height: 4),
                _buildInfoRow(Icons.person, dataSesi.lecturer.employeeName),
                const SizedBox(height: 4),
                _buildInfoRow(Icons.book, dataSesi.className),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
            ),
            child: const Text("Buka Sesi"),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[500], size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
