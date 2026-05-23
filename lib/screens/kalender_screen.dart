import 'package:flutter/material.dart';
import 'package:pegawai/components/sesi_card.dart';
import 'package:pegawai/providers/sesi_provider.dart';
import 'package:pegawai/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class KalenderScreen extends StatefulWidget {
  const KalenderScreen({super.key});

  @override
  State<KalenderScreen> createState() => _KalenderScreenState();
}

class _KalenderScreenState extends State<KalenderScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<SesiProvider>().getDataSesi();
      }
    });
  }

  DateTime _selectedDay = DateTime(1990, 1, 8);
  DateTime _focusedDay = DateTime(1990, 1, 8);

  @override
  Widget build(BuildContext context) {
    final SesiProvider sesiProvider = context.watch<SesiProvider>();

    final allEvents = sesiProvider.getEventsGroupedByDate(sesiProvider.data!);

    final selectedEvents =
        allEvents[DateTime(
          _selectedDay.year,
          _selectedDay.month,
          _selectedDay.day,
        )] ??
        [];

    return Scaffold(
      appBar: AppBar(title: const Text("Jadwal Kuliah")),
      body: sesiProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(1980, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),

                  eventLoader: (day) {
                    final normalizedDay = DateTime(
                      day.year,
                      day.month,
                      day.day,
                    );
                    return allEvents[normalizedDay] ?? [];
                  },

                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },

                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                const Divider(),

                Expanded(
                  child: selectedEvents.isEmpty
                      ? const Center(
                          child: Text("Tidak ada jadwal pada tanggal ini"),
                        )
                      : ListView.builder(
                          itemCount: selectedEvents.length,
                          itemBuilder: (context, index) {
                            final item = selectedEvents[index];
                            return Padding(
                              padding: EdgeInsetsGeometry.all(16),
                              child: SesiCard(dataSesi: item),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
