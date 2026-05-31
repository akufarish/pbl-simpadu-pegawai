import 'package:flutter/material.dart';
import 'package:pegawai/utils/app_colors.dart';

class PresensiMahasiswa extends StatefulWidget {
  const PresensiMahasiswa({super.key});

  @override
  State<PresensiMahasiswa> createState() => _PresensiMahasiswaState();
}

class _PresensiMahasiswaState extends State<PresensiMahasiswa> {
  String? _selectedStatus;

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
          const Expanded(
            child: Text(
              "Joy",
              style: TextStyle(
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
    bool isSelected = _selectedStatus == data;

    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedStatus = data;
          });
          debugPrint("Status dipilih: $data");
        },
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
