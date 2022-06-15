import 'package:flutter/services.dart';
import '/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlarmCubit extends Cubit<AlarmStates>{
  AlarmCubit() : super(AlarmInitialStates());
  static AlarmCubit get(context) => BlocProvider.of<AlarmCubit>(context);

  ///////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////
  List<String> prayerTimesDay = [
    '14-06-2022',
    'Tuesday',
    '03:08 AM',
    '04:53 AM',
    '11:55 AM',
    '03:31 PM',
    '06:57 PM',
    '08:31 PM',
  ];
  //////////////////////////
  void getPrayerTimesNow() {
    int yearNow = DateTime.now().year;

    String monthNow = DateTime.now().month < 10
        ? '0${DateTime.now().month}'
        : DateTime.now().month.toString();

    String dayNow = DateTime.now().day < 10
        ? '0${DateTime.now().day}'
        : DateTime.now().day.toString();

    getTimes(dayNow, monthNow, yearNow);
  }

  //////////////////////////
  void getTimes(day, month, year) {
    rootBundle.loadString("assets/prayer_times/calender$year.txt").then(
      (calender) {
        List<String> listOfDays = calender.split('#');
        ///////////////
        String returnedDay = listOfDays.firstWhere((element) {
          return element.contains('$day-$month-$year');
        });
        ////////////////
        prayerTimesDay = returnedDay.trim().split('|');
        ///////////////
        emit(AlarmGetPrayerTimesOfDaySuccessStates());
      },
    ).catchError((error) {
      emit(AlarmGetPrayerTimesOfDayErrorStates(error));
    });
  }

  ///////////////////////
  int index = 0;
  void changePrayerTimes({required bool isClickedLeft, bool reset = false}) {
    //if clicked left >>> --index or clicked right >>> ++index
    isClickedLeft ? --index : ++index;
    ///////////////
    if (index == 0) {
      getPrayerTimesNow();
    } else {
      DateTime dateTime = DateTime.now().add(Duration(days: index));

      int year = dateTime.year;

      String month = dateTime.month < 10
          ? '0${dateTime.month}'
          : dateTime.month.toString();

      String day =
          dateTime.day < 10 ? '0${dateTime.day}' : dateTime.day.toString();

      getTimes(day, month, year);
    }
  }

  ///////////////////////
  void resetValues() {
    index = 0;
    emit(AlarmResetValuesStates());
    getPrayerTimesNow();
  }
}
