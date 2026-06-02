import 'package:flutter/material.dart';
import 'package:pegawai/models/presensi.dart';
import 'package:pegawai/providers/presensi_provider.dart';
import 'package:pegawai/utils/app_colors.dart';
import 'package:provider/provider.dart';

class PresensiMahasiswa extends StatefulWidget {
  final String name;
  final String detailId;
  final String sesiId;
  final String? initialStatus;

  const PresensiMahasiswa({
    super.key,
    required this.name,
    required this.detailId,
    required this.sesiId,
    this.initialStatus,
  });

  @override
  State<PresensiMahasiswa> createState() => _PresensiMahasiswaState();
}

class _PresensiMahasiswaState extends State<PresensiMahasiswa> {
  String? _selectedStatus;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialStatus != null) {
      _selectedStatus = widget.initialStatus;
    }
  }

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
              widget.name,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _isUpdating
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : Row(
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
    bool isSelected = _selectedStatus?.toLowerCase() == data.toLowerCase();

    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: InkWell(
        onTap: () async {
          if (_selectedStatus?.toLowerCase() == data.toLowerCase()) return;

          setState(() {
            _isUpdating = true;
          });

          final payload = UpdatePresensiMahasiswa(
            sesiId: widget.sesiId,
            detailId: widget.detailId,
            status: data,
          );

          bool sukses = await context
              .read<PresensiProvider>()
              .updatePresensiMahasiswa(payload);

          if (!mounted) return;

          if (sukses) {
            setState(() {
              _selectedStatus = data;
              _isUpdating = false;
            });
          } else {
            setState(() {
              _isUpdating = false;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Gagal mengubah presensi ${widget.name}")),
            );
          }
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
