import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pegawai/models/tugas.dart';
import 'package:pegawai/providers/tugas_provider.dart';
import 'package:provider/provider.dart';

class UploadTugas extends StatefulWidget {
  const UploadTugas({super.key});

  @override
  State<UploadTugas> createState() => _UploadTugasState();
}

class _UploadTugasState extends State<UploadTugas> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<TugasProvider>().getTugas();
      }
    });
  }

  void uploadFile() async {
    FilePickerResult? result = await FilePicker.pickFiles();

    if (result != null) {
      FilePickerResult? result = await FilePicker.pickFiles(
        allowMultiple: true,
      );
      List<File> files = result!.paths.map((path) => File(path!)).toList();
      debugPrint("upload_file: $files");
      if (!mounted) return;
      context.read<TugasProvider>().uploadTugas(files);
    } else {
      debugPrint("Samting wong");
    }
  }

  @override
  Widget build(BuildContext context) {
    TugasProvider tugasProvider = context.watch<TugasProvider>();
    return Scaffold(
      body: tugasProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.75,
                ),
                itemCount: tugasProvider.data.length,
                itemBuilder: (context, index) {
                  final Tugas tugas = tugasProvider.data[index];

                  return SizedBox(
                    width: 100,
                    height: 100,
                    child: Card(
                      child: InkWell(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.file_copy_rounded, size: 50),
                            SizedBox(height: 12),
                            Text(
                              tugas.originaFileName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: uploadFile,
        child: Icon(Icons.add),
      ),
    );
  }
}
