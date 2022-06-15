class AlarmStates {}

class AlarmInitialStates extends AlarmStates {}

class AlarmGetPrayerTimesOfDaySuccessStates extends AlarmStates {}

class AlarmGetPrayerTimesOfDayErrorStates extends AlarmStates {
  String error;
  AlarmGetPrayerTimesOfDayErrorStates(this.error);
}

class AlarmResetValuesStates extends AlarmStates {}
