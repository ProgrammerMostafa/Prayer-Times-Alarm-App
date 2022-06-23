import 'package:flutter/services.dart';
import '/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlarmCubit extends Cubit<AlarmStates> {
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
  ////////////////////////////////////////////////
  void getPrayerTimesNow() {
    getTimes(dateTime: DateTime.now());
  }

  //////////////////////////
  void getTimes({required DateTime dateTime}) {
    int year = dateTime.year;

    String month =
        dateTime.month < 10 ? '0${dateTime.month}' : dateTime.month.toString();

    String day =
        dateTime.day < 10 ? '0${dateTime.day}' : dateTime.day.toString();

    ///////////////////////////////////////////
    // To read asset file
    rootBundle.loadString("assets/prayer_times/calender$year.txt").then(
      (calender) {
        List<String> listOfDays = calender.split('#');
        ///////////////
        String returnedDay = listOfDays.firstWhere((element) {
          return element.contains('$day-$month-$year');
        });
        //////////////
        prayerTimesDay = returnedDay.trim().split('|');
        //////////////
        emit(AlarmGetPrayerTimesOfDaySuccessState());
      },
    ).catchError((error) {
      emit(AlarmGetPrayerTimesOfDayErrorState(error));
    });
  }

  ///////////////////////
  int index = 0;
  void changePrayerTimes({required bool isClickedLeft}) {
    //if clicked left >>> --index or clicked right >>> ++index
    isClickedLeft ? --index : ++index;
    emit(AlarmChangeIndexValueSuccessState());
    //////////////////////////////////////////
    DateTime dateTime = DateTime.now().add(Duration(days: index));
    getTimes(dateTime: dateTime);
  }

  ///////////////////////
  void resetValues() {
    index = 0;
    emit(AlarmChangeIndexValueSuccessState());
    getTimes(dateTime: DateTime.now());
  }
}
