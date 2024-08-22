import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/data_models/weather_model.dart';
import 'package:sample/services/api_call.dart';
import 'package:sample/widgets/weather_card.dart';

import '../alarm_home/alarm_home_controller.dart';

class CurrentWeather extends StatelessWidget {
  CurrentWeather({super.key});
  final controller = Get.put(AlarmHomeController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // if data has errors
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error.toString()} occurred',
                style: const TextStyle(fontSize: 18),
              ),
            );

            // if data has no errors
          } else if (snapshot.hasData) {
            // Extracting data from snapshot object
            final data = snapshot.data as Weather;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.8, 1),
                  colors: <Color>[
                    Color.fromARGB(199, 170, 174, 218),
                    Color.fromARGB(255, 120, 196, 219),
                    Color.fromARGB(255, 232, 191, 170),
                    Color.fromARGB(255, 232, 145, 59),
                  ],
                  tileMode: TileMode.mirror,
                ),
              ),
              width: double.infinity,
              height: double.infinity,
              child: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                              Text(
                                controller.location,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                          Text(
                            data.weatherData![0].description != null
                                ? data.weatherData![0].description!
                                    .capitalizeFirst!
                                : '',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                          Text(
                            "${data.main!.temp!.toStringAsFixed(0)}°C",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Feels Like ${data.main!.feelsLike!.toStringAsFixed(0)}°C",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          Expanded(
                              child: GridView.count(
                            primary: false,
                            // padding: const EdgeInsets.all(20),
                            // crossAxisSpacing: 10,
                            // mainAxisSpacing: 10,
                            crossAxisCount: 3,
                            children: [
                              weatherCard(
                                value: data.main!.pressure.toString(),
                                icon: Icons.wb_iridescent_rounded,
                                text: 'Pressure',
                              ),
                              weatherCard(
                                value: data.main!.humidity.toString(),
                                icon: Icons.water_drop_outlined,
                                text: 'Humidity',
                              ),
                              weatherCard(
                                value: data.wind!.speed.toString(),
                                icon: Icons.wind_power_outlined,
                                text: 'Wind Speed',
                              ),
                              weatherCard(
                                value: controller
                                    .getTimeFromEpoch(data.sys!.sunrise!),
                                icon: Icons.sunny_snowing,
                                text: 'Sunrise',
                              ),
                              int.parse(data.main!.temp!.toStringAsFixed(0)) >=
                                      30
                                  ? const Icon(
                                      Icons.sunny,
                                      size: 50,
                                      color: Colors.amber,
                                    )
                                  : const Icon(
                                      Icons.cloud,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                              weatherCard(
                                value: controller
                                    .getTimeFromEpoch(data.sys!.sunset!),
                                icon: Icons.sunny_snowing,
                                text: 'Sunset',
                              ),
                            ],
                          ))
                          // Expanded(
                          //   child: GridView.count(
                          //       crossAxisCount: 4,
                          //       children: List.generate(
                          //         4,
                          //         (index) {
                          //           return Container(
                          //             decoration: BoxDecoration(
                          //                 color: Colors.blue.withOpacity(0.5),
                          //                 borderRadius: const BorderRadius.all(
                          //                     Radius.circular(10))),
                          //             margin: const EdgeInsets.all(10),
                          //             child: Center(
                          //               child: Text(
                          //                 'Item $index',
                          //                 style: const TextStyle(
                          //                   color: Colors.white,
                          //                   fontSize: 20,
                          //                 ),
                          //               ),
                          //             ),
                          //           );
                          //         },
                          //       )),
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Center(
            child: Text("State ${snapshot.connectionState}"),
          );
        }
        return const Center(
          child: Text("Server timed out!"),
        );
      },
      future: getCurrentWeather(controller.location),
    );
  }
}
