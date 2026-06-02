import 'package:flutter/material.dart';
import 'package:pegawai/utils/app_colors.dart';

class PresensiMahasiswa extends StatelessWidget {
  final String name;
  final String detailId;
  final String sesiId;
  final String currentStatus;
  final ValueChanged<String> onStatusChanged;

  const PresensiMahasiswa({
    super.key,
    required this.name,
    required this.detailId,
    required this.sesiId,
    required this.currentStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primaryColor,
            child: const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _kehadiranButton("Alpha", "A"),
              _kehadiranButton("Hadir", "H"),
              _kehadiranButton("Sakit", "S"),
              _kehadiranButton("Izin", "I"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _kehadiranButton(String data, String label) {
    bool isSelected = currentStatus.toLowerCase() == data.toLowerCase();

    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: InkWell(
        onTap: () => onStatusChanged(data),
        borderRadius: BorderRadius.circular(50),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected
                ? AppColors.primaryColor
                : AppColors.secondaryColor,
            border: Border.all(
              color: isSelected ? AppColors.primaryColor : Colors.transparent,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
