import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/cubit/states.dart';
import '../shared/cubit/cubit.dart';

class PrayerTimesScreen extends StatelessWidget {
  const PrayerTimesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AlarmCubit, AlarmStates>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        AlarmCubit cubit = AlarmCubit.get(ctx);
        return Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/images/back.jpg', fit: BoxFit.fill),
            //////////////////
            buildFirstRow(cubit),
            buildSecondRow(cubit),
            //////////////////
            buildPrayerTimesList(cubit),
          ],
        );
      },
    );
  }

  ///////////////////////////////
  buildFirstRow(AlarmCubit cubit) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildClickedImage(cubit, true),
          ////////////////////////////////
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              child: Text(
                cubit.prayerTimesDay[1],
                style: TextStyle(
                  color: cubit.index == 0
                      ? const Color.fromARGB(255, 252, 144, 55)
                      : Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ////////////////////////////////
          buildClickedImage(cubit, false),
        ],
      ),
    );
  }

  //////////////////////////
  InkWell buildClickedImage(AlarmCubit cubit, bool isLeft) {
    return InkWell(
      onTap: () {
        cubit.changePrayerTimes(isClickedLeft: isLeft);
      },
      child: Image.asset(
        'assets/images/arrow_${isLeft ? 'back' : 'forward'}.png',
        color: const Color.fromARGB(255, 252, 144, 55),
        width: 40,
        height: 40,
      ),
    );
  }

  ////////////////////////////////////////////////////////////////
  buildSecondRow(AlarmCubit cubit) {
    String date = cubit.prayerTimesDay[0].replaceAll('-', '/');
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 62),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            alignment: Alignment.center,
            child: Text(
              date,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////
  buildPrayerTimesList(AlarmCubit cubit) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 130),
      child: Column(
        children: [
          buildPrayerRow(
            image: '1',
            prayerName: 'Fajr',
            prayerTime: cubit.prayerTimesDay[2],
          ),
          buildPrayerRow(
            image: '2',
            prayerName: 'Sunrise',
            prayerTime: cubit.prayerTimesDay[3],
          ),
          buildPrayerRow(
            image: '3',
            prayerName: 'Dhuhr',
            prayerTime: cubit.prayerTimesDay[4],
          ),
          buildPrayerRow(
            image: '4',
            prayerName: 'Asr',
            prayerTime: cubit.prayerTimesDay[5],
          ),
          buildPrayerRow(
            image: '5',
            prayerName: 'Maghrib',
            prayerTime: cubit.prayerTimesDay[6],
          ),
          buildPrayerRow(
            image: '6',
            prayerName: 'Isha',
            prayerTime: cubit.prayerTimesDay[7],
          ),
        ],
      ),
    );
  }

  //////////////////
  buildPrayerRow({
    required String image,
    required String prayerName,
    required String prayerTime,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/image$image.png',
            color: Colors.black,
            width: 30,
            height: 30,
          ),
          Expanded(
            child: Container(
              height: 30,
              alignment: Alignment.centerLeft,
              child: Text(
                ' $prayerName',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Container(
            height: 30,
            alignment: Alignment.center,
            child: Text(
              prayerTime,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
