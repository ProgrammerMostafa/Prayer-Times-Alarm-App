class AlarmStates {}

class AlarmInitialStates extends AlarmStates {}

class AlarmGetPrayerTimesOfDaySuccessState extends AlarmStates {}

class AlarmGetPrayerTimesOfDayErrorState extends AlarmStates {
  String error;
  AlarmGetPrayerTimesOfDayErrorState(this.error);
}

class AlarmChangeIndexValueSuccessState extends AlarmStates {}
