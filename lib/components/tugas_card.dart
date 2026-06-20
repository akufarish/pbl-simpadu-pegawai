import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pegawai/models/tugas.dart';

class TugasItemCard extends StatelessWidget {
  final Tugas tugas;
  final VoidCallback onTap;

  const TugasItemCard({super.key, required this.tugas, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Icon(
              Icons.assignment_rounded,
              color: Theme.of(context).primaryColor,
            ),
          ),
          title: Text(
            tugas.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              Text(
                tugas.description ?? "-",
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(
                    Icons.alarm_rounded,
                    size: 16,
                    color: Colors.redAccent,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      "Deadline: ${tugas.deadline}",
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
