import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather_app/weather_model.dart';


void main() {
  runApp(HomeScreen());
}

getDataFromInternet() async {
  Response result = await get(Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?lat=13.086616&lon=104.220411&appid=59a0507726eedfa7d709a3ccfcf7c10f&units=metric"));
  if (result.statusCode == 200) {
    weather_model m = weather_model.fromJson(jsonDecode(result.body));
    return m;
  } else {
    print(result.statusCode);
    return null;
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
          title: const Center(
            child: Text(""),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {               
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: getDataFromInternet(),
          builder: ((BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              weather_model m = snapshot.data;
              return Column(
          children: [
            Text(
              m.name!,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Icon(Icons.wb_sunny_outlined, size: 90),
            Text(" ${m.main!.temp!.round()}°",
                style: const TextStyle(fontSize: 98, fontWeight: FontWeight.w100)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("max\n${m.main!.tempMax!.round()}°"),
                const SizedBox(
                  child: VerticalDivider(color: Colors.grey),
                  height: 32,
                ),
                Text("min\n${m.main!.tempMin!.round()}°"),
              ],
            ),
            const Divider(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.all(12),
                    child: const Column(
                      children: [
                        Text("Sun, 5PM"),
                        Icon(Icons.sunny),
                        Text("25°"),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(12),
                    child: const Column(
                      children: [
                        Text("Sun, 8PM"),
                        Icon(Icons.thunderstorm),
                        Text("21°"),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(12),
                    child: const Column(
                      children: [
                        Text("Sun, 11PM"),
                        Icon(Icons.cloud),
                        Text("15°"),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(12),
                    child: const Column(
                      children: [
                        Text("Sun, 2AM"),
                        Icon(Icons.sunny),
                        Text("14°"),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(12),
                    child: const Column(
                      children: [
                        Text("Sun, 5AM"),
                        Icon(Icons.sunny),
                        Text("13°"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text("wind speed"),
                      Text("6 km/h"),
                    ],
                  ),
                  SizedBox(
                    child: VerticalDivider(color: Colors.grey),
                    height: 32,
                  ),
                  Column(
                    children: [
                      Text("sunrise"),
                      Text("5:52 AM"),
                    ],
                  ),
                  SizedBox(
                    child: VerticalDivider(color: Colors.grey),
                    height: 32,
                  ),
                  Column(
                    children: [
                      Text("sunset"),
                      Text("6:25 PM"),
                    ],
                  ),
                  SizedBox(
                    child: VerticalDivider(color: Colors.grey),
                    height: 32,
                  ),
                  Column(
                    children: [
                      Text("humidity"),
                      Text("56%"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
            } else {
              return Center(
                child: LoadingAnimationWidget.twistingDots(
                  leftDotColor: Colors.blue,
                  rightDotColor: Colors.yellow,
                  size: 200,
                ),
              );
            }
          }),
        ),
      ),
    );
  }

  SizedBox MyDivider() {
    return const SizedBox(
      child: VerticalDivider(color: Colors.grey),
      height: 32,
    );
  }

  Column WeatherDescription(String text1, String text2) {
    return Column(
      children: [
        Text(text1),
        Text(text2),
      ],
    );
  }
}

class TimeTemperature extends StatelessWidget {
  String? time;
  IconData? icon;
  String? temperature;

  TimeTemperature(this.time, this.icon, this.temperature);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: Column(
        children: [
          Text(time!),
          Icon(icon!),
          Text(temperature!),
        ],
      ),
    );
  }
}
