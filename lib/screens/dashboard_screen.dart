import 'package:flutter/material.dart';
import 'package:pegawai/models/user.dart';
import 'package:pegawai/providers/user_provider.dart';
import 'package:pegawai/utils/app_colors.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<UserProvider>().profile();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = context.watch<UserProvider>();
    final UserResponse? user = userProvider.data;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 102,
              width: double.infinity,
              color: AppColors.primaryColor,
              child: Padding(
                padding: EdgeInsetsGeometry.only(top: 28, left: 28, right: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selamat Datang ${user?.name ?? "Joy"}",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      "Kada tahu handak diisi apa",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.primaryColor,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsetsGeometry.only(
                  top: 5,
                  left: 28,
                  right: 28,
                  bottom: 28,
                ),
                child: SizedBox(
                  height: 348,
                  child: PageView(
                    children: [
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsetsGeometry.only(
                            top: 20,
                            left: 33,
                            right: 33,
                            bottom: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Kelas Hari Ini",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Text(
                                        "Rabu, 30 Feb",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, "/kalender");
                                    },
                                    style: IconButton.styleFrom(
                                      backgroundColor: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.all(10),
                                    ),
                                    icon: const Icon(
                                      Icons.calendar_month,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                      Card(child: Text("1")),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
