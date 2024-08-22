import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sample/services/api_call.dart';
import 'package:sample/widgets/alert_dialog.dart';
import 'package:sample/widgets/show_toast.dart';
import 'package:sample/widgets/text_field_widget.dart';

class AlarmHomeController extends GetxController {
  TextEditingController alarmlabel = TextEditingController();
  TextEditingController time = TextEditingController();
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay? picked;
  DateTime? alarmdateTime;

  var alarmSettings;
  addAlarm(dateTime, notificationTitle, notificationBody) async {
    alarmSettings = AlarmSettings(
      id: 42,
      dateTime: dateTime,
      assetAudioPath: 'assets/alarm.mp3',
      loopAudio: true,
      vibrate: true,
      volume: 1,
      fadeDuration: 3.0,
      notificationTitle: notificationTitle,
      notificationBody: notificationBody,
      androidFullScreenIntent: true,
      enableNotificationOnKill: Platform.isIOS,
    );
    await Alarm.set(alarmSettings: alarmSettings);
    await Alarm.setNotificationOnAppKillContent(
        notificationTitle, notificationBody);

    showToast(message: 'Alarm Scheduled at ${time.text}');
  }

  alarmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
            child: Container(
                height: 200,
                width: 300,
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextFieldWidget(
                        controller: alarmlabel,
                        contentPaddingHorizontal: 10,
                        // fillColor: Colors.grey[100,
                        contentPaddingVertical: 10,
                        hintText: 'Label',
                        color: Colors.black,
                        borderColor: Colors.grey,
                        fontSize: 12),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFieldWidget(
                        prefixIcon: IconButton(
                          iconSize: 20,
                          icon: const Icon(
                            Icons.alarm,
                            size: 20,
                          ),
                          onPressed: () {
                            selectTime(context);
                          },
                        ),
                        controller: time,
                        contentPaddingHorizontal: 10,
                        isReadOnly: true,
                        onTap: () => selectTime(context),
                        // fillColor: Colors.grey[100,
                        contentPaddingVertical: 10,
                        hintText: 'Time',
                        color: Colors.black,
                        borderColor: Colors.grey,
                        fontSize: 12),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                        addAlarm(alarmdateTime, alarmlabel.text, '');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        width: 100,
                        height: 30,
                        child: const Center(
                            child: Text(
                          'Set Alarm',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    )
                  ],
                )));
      },
    );
  }

  Future<void> selectTime(BuildContext context) async {
    picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null) {
      _time = picked!;
      time.text = _time.format(context);
      print(picked);
      final now = DateTime.now();
      alarmdateTime =
          DateTime(now.year, now.month, now.day, _time.hour, _time.minute);
    }

    // });
  }

  bool isError = false;
  String error = '';
  String location = '';
  double lat = 0.0;
  double lon = 0.0;
  getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      isError = true;
      error = "Location services are disabled & then restart the application!";
      // });
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      lat = value.latitude;
      lon = value.longitude;
      print('LATITUDE $lat');
      print('LONGITUDE $lon');
      getCityName();

      return value;
    });
  }

  getCityName() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);

    Placemark place = placemarks[0];

    // setState(() {
    location =
        '${place.subLocality != '' ? place.subLocality : place.locality}';
    getCurrentWeather(location);
    print(
        '========LOCATION====${place.locality}=${place.subLocality}==$location');
    // });
  }

  // getWeatherData() async {
  //   try {
  //     final response = getCurrentWeather(lat, lon);

  //     if (response.statusCode == 200) {
  //       var jsonString = jsonDecode(response.body);
  //       weatherData = WeatherData(
  //           WeatherDataCurrent.fromJson(jsonString),
  //           WeatherDataHourly.fromJson(jsonString),
  //           WeatherDataDaily.fromJson(jsonString));
  //       // print(jsonString);
  //       // getDaysAndDates();
  //       // getHourlyTime();
  //       // getHourlyData();

  //       // setState(() {
  //       // isLoading = false;
  //       // });

  //       return weatherData;
  //     } else {
  //       return "Error";
  //     }
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }

  getTimeFromEpoch(int epoch) {
    DateTime datetime = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
    return DateFormat.jm().format(datetime);
  }
}
