import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    getWeather();
  }

  var image = '';
  var temperature = '--';
  var description = '----------';
  var mainWeather = '----------';
  var humidity = '--';
  var windSpeed = '--';

  String cityName = 'Germany';

  Future<void> getWeather() async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=a762fe37571a01c4d3860d9ba3b3ac8b',
    );
    try {
      var response = await http.get(url);
      final result = jsonDecode(response.body);
      setState(() {
        temperature = result['main']['temp'].toString();
        description = result['weather'][0]['description'];
        mainWeather = result['weather'][0]['main'];
        humidity = result['main']['humidity'].toString();
        windSpeed = result['wind']['speed'].toString();
        image = result['weather'][0]['icon'].toString();
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController cityController = TextEditingController();
    return Scaffold(
      backgroundColor: const Color(0xff4A91FF),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xff47BFDF),
                Color(0xff4A91FF),
              ],
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 70, bottom: 20),
                child: TextFormField(
                  controller: cityController,
                  onChanged: (value) {
                    cityName = value;
                    getWeather();
                  },
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    suffixIcon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    hintText: 'Search City',
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide:
                          const BorderSide(width: 2, color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide:
                          const BorderSide(width: 2, color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide:
                          const BorderSide(width: 2, color: Colors.white),
                    ),
                  ),
                ),
              ),
              image == ''
                  ? Padding(
                      padding: const EdgeInsets.all(20),
                      child: Image.asset(
                        'assets/images/image.png',
                        height: 200,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 0, bottom: 0),
                      child: Image.network(
                        "https://openweathermap.org/img/wn/$image@4x.png",
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  mainWeather,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              Container(
                height: 400,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.purple[100],
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        cityName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        DateFormat("EEEE,d MMM yyyy, HH:mm a")
                            .format(DateTime.now()),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        '$temperature\u00B0',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        description,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Wind | $windSpeed km/h',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Humidity | $humidity %',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
