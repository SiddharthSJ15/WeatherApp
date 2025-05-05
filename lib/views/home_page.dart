import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/models.dart';
import 'package:weather_app/service/weather_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Using global variable as in your original code
WeatherModel? weatherData;

class _HomePageState extends State<HomePage> {
  TextEditingController cityController = TextEditingController();
  bool isLoading = true;
  String? errorMessage;
  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;
  Future<Position> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Service Disabled')));
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  final service = WeatherService();

  void _loadWeather() async {
    _currentLocation = await _getCurrentLocation();
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    try {
      final data = await service.getWeather(cityController.text);
      setState(() {
        weatherData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Enter a city!!!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double mediaHeight = mediaQuery.size.height;
    double mediaWidth = mediaQuery.size.width;
    print('mediaHeight: $mediaHeight');
    print('mediaWidth: $mediaWidth');

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: Text('Weather App', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey.shade800,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              isLoading
                  ? Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                  : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Search bar
                        _buildSearchBar(),
                        SizedBox(height: 20),

                        // "${_currentLocation}"
                        Text(
                          "Latitude = ${_currentLocation?.latitude} ; Longitude = ${_currentLocation?.longitude}",
                        ),
                        SizedBox(height: 20),

                        // Main weather card
                        _buildMainWeatherCard(),

                        SizedBox(height: 20),

                        // Additional details card
                        _buildDetailsCard(),
                      ],
                    ),
                  ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: cityController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Enter city name',
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.grey.shade800,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: _loadWeather,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text('Search'),
        ),
      ],
    );
  }

  Widget _buildMainWeatherCard() {
    if (weatherData == null) {
      return Card(
        color: Colors.blueGrey.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(child: Text('No weather data available')),
        ),
      );
    }

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.blueGrey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // City name and temperature
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  weatherData?.name ?? 'Unknown',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${((weatherData?.main?.temp ?? 0) - 273.15).toStringAsFixed(1)}°C',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Weather animation in fixed size container
            Container(
              height: 180,
              alignment: Alignment.center,
              child:
                  weatherData?.weather != null &&
                          weatherData!.weather!.isNotEmpty
                      ? animationWidget(weatherData!.weather![0].id)
                      : CircularProgressIndicator(),
            ),

            SizedBox(height: 16),

            // Weather description
            Center(
              child: Text(
                weatherData?.weather != null && weatherData!.weather!.isNotEmpty
                    ? '${weatherData!.weather![0].main} - ${weatherData!.weather![0].description}'
                    : 'Unknown weather',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard() {
    if (weatherData == null) return SizedBox();

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.blueGrey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Weather Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),

            // Weather details in grid
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    Icons.thermostat,
                    'Feels Like',
                    '${((weatherData?.main?.feelsLike ?? 0) - 273.15).toStringAsFixed(1)}°C',
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    Icons.water_drop,
                    'Humidity',
                    '${weatherData?.main?.humidity ?? 0}%',
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    Icons.air,
                    'Wind Speed',
                    '${weatherData?.wind?.speed ?? 0} m/s',
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    Icons.compress,
                    'Pressure',
                    '${weatherData?.main?.pressure ?? 0} hPa',
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    Icons.visibility,
                    'Visibility',
                    '${(weatherData?.visibility ?? 0) / 1000} km',
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    Icons.cloud,
                    'Cloudiness',
                    '${weatherData?.clouds?.all ?? 0}%',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(icon, size: 28, color: Colors.blue.shade800),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              ),
              Text(
                value,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget animationWidget(int? weather) {
    if (weather == null) return Container();

    int id = weather;
    String assetPath;

    if (id >= 200 && id < 300) {
      // Thunderstorm
      assetPath = 'assets/morningRainWithThunderstorm.json';
    } else if (id >= 300 && id < 400) {
      // Drizzle
      assetPath = 'assets/fewClouds.json';
    } else if (id >= 500 && id < 600) {
      // Rain
      assetPath = 'assets/fewClouds.json';
    } else if (id >= 600 && id < 700) {
      // Snow
      assetPath = 'assets/fewClouds.json';
    } else if (id == 800) {
      // Clear sky
      assetPath =
          'assets/Lightning.json'; // This should probably be a clear sky animation
    } else if (id >= 801 && id < 900) {
      // Clouds
      assetPath = 'assets/cloud.json';
    } else {
      // Default
      return Text(
        'Weather animation not available',
        style: TextStyle(color: Colors.grey),
      );
    }

    // Return the animation in a fixed size container to avoid layout issues
    return Lottie.asset(
      assetPath,
      fit: BoxFit.contain,
      reverse: true,
      height: 180,
      width: double.infinity,
    );
  }
}
