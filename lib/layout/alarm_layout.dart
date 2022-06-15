import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/alarm_screen.dart';
import '../modules/prayer_times_screen.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class AlarmLayout extends StatefulWidget {
  const AlarmLayout({Key? key}) : super(key: key);

  @override
  State<AlarmLayout> createState() => _AlarmLayoutState();
}

class _AlarmLayoutState extends State<AlarmLayout>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AlarmCubit, AlarmStates>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        AlarmCubit cubit = AlarmCubit.get(ctx);
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 5,
            backgroundColor: Colors.teal,
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.black,
              indicatorWeight: 2.5,
              labelStyle: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[300],
              tabs: const [
                Tab(child: Text('PRAYER TIMES')),
                Tab(child: Text('ALARM')),
              ],
              onTap: (index) {
                if (index == 0) {
                  cubit.resetValues();
                }
              },
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: const [
              PrayerTimesScreen(),
              AlarmScreen(),
            ],
          ),
        );
      },
    );
  }
}
