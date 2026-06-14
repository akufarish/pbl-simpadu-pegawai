import 'package:flutter/material.dart';

class VerifikasiCard extends StatelessWidget {
  final String nama, value, status, label;
  const VerifikasiCard({
    super.key,
    required this.nama,
    required this.value,
    required this.status,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 14,
          left: 23,
          right: 23,
          bottom: 20,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.account_circle, size: 42),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    nama,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),

                const SizedBox(width: 10),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 30,
                  constraints: const BoxConstraints(minWidth: 80),
                  decoration: BoxDecoration(
                    color: status.toLowerCase() == "pending"
                        ? Colors.orange
                        : status.toLowerCase() == "approved"
                        ? Colors.green
                        : Colors.red,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      status,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  label.toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Expanded(child: Text(value, textAlign: TextAlign.right)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
