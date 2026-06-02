import 'package:flutter/material.dart';
import 'package:pegawai/models/pengampu.dart';

class DetailMatkulScreen extends StatefulWidget {
  final Pengampu pengampu;
  const DetailMatkulScreen({super.key, required this.pengampu});

  @override
  State<DetailMatkulScreen> createState() => _DetailMatkulScreenState();
}

class _DetailMatkulScreenState extends State<DetailMatkulScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: CustomScrollView(
        slivers: [SliverToBoxAdapter(child: Text("Test"))],
      ),
    );
  }
}
