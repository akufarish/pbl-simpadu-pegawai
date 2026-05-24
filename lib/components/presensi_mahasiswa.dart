import 'package:flutter/material.dart';
import 'package:pegawai/utils/app_colors.dart';

class PresensiMahasiswa extends StatefulWidget {
  const PresensiMahasiswa({super.key});

  @override
  State<PresensiMahasiswa> createState() => _PresensiMahasiswaState();
}

class _PresensiMahasiswaState extends State<PresensiMahasiswa> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primaryColor,
            child: Icon(Icons.person, color: Colors.white),
          ),
          SizedBox(width: 13),
          Expanded(
            child: Text("Joy", style: TextStyle(color: Colors.black)),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              children: [
                _kehadiranButton("Alpha", "A"),
                _kehadiranButton("Hadir", "H"),
                _kehadiranButton("Sakit", "S"),
                _kehadiranButton("Izin", "I"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding _kehadiranButton(String data, String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: InkWell(
        onTap: () => {},
        borderRadius: BorderRadius.circular(50),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor,
          ),
          child: Center(
            child: Text(label, style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
