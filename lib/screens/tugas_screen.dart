import 'package:flutter/material.dart';
import 'package:pegawai/utils/app_colors.dart';

class TugasScreen extends StatefulWidget {
  const TugasScreen({super.key});

  @override
  State<TugasScreen> createState() => _TugasScreenState();
}

class _TugasScreenState extends State<TugasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/upload-tugas");
        },
        backgroundColor: AppColors.primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
