class WeatherModel {
  Coord? coord;
  List<Weather>? weather;
  String? base;
  Main? main;
  int? visibility;
  Wind? wind;
  Clouds? clouds;
  int? dt;
  Sys? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;
  WeatherModel({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });
  WeatherModel.fromJson(Map<String, dynamic> json) {
    coord = Coord.fromJson(json['coord']);
    weather = List<Weather>.from(
      json['weather'].map((item) => Weather.fromJson(item)),
    );
    // (json['weather'] as List)
    //     .map((item) => Weather.fromJson(item))
    //     .toList();
    base = json['base'];
    main = Main.fromJson(json['main']);
    visibility = json['visibility'];
    wind = Wind.fromJson(json['wind']);
    clouds = Clouds.fromJson(json['clouds']);
    dt = json['dt'];
    sys = Sys.fromJson(json['sys']);
    timezone = json['timezone'];
    id = json['id'];
    name = json['name'];
    cod = json['cod'];
  }
}

class Coord {
  double? lon;
  double? lat;
  Coord({this.lon, this.lat});
  Coord.fromJson(Map<String, dynamic> json) {
    lon = json['lon'];
    lat = json['lat'];
  }
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;
  Weather({this.id, this.main, this.description, this.icon});
  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }
}

class Main {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;
  int? seaLevel;
  int? grndLevel;
  Main({
    this.temp,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.feelsLike,
    this.grndLevel,
  });
  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    feelsLike = json['feels_like'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    seaLevel = json['sea_level'];
    grndLevel = json['grnd_level'];
  }
}

class Wind {
  double? speed;
  int? deg;
  double? gust;
  Wind({this.speed, this.deg, this.gust});
  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
    deg = json['deg'];
    gust = json['gust'];
  }
}

class Clouds {
  int? all;
  Clouds({this.all});
  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }
}

class Sys {
  String? country;
  int? sunrise;
  int? sunset;
  Sys({this.country, this.sunrise, this.sunset});
  Sys.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }
}

// class WeatherModel {
//   Coord? coord;
//   List<Weather>? weather;
//   String? base;
//   Main? main;
//   int? visibility;
//   Wind? wind;
//   Clouds? clouds;
//   int? dt;
//   Sys? sys;
//   int? timezone;
//   int? id;
//   String? name;
//   int? cod;

//   WeatherModel({
//     this.coord,
//     this.weather,
//     this.base,
//     this.main,
//     this.visibility,
//     this.wind,
//     this.clouds,
//     this.dt,
//     this.sys,
//     this.timezone,
//     this.id,
//     this.name,
//     this.cod,
//   });
//   WeatherModel.fromJson(Map<String, dynamic> json) {
//     coord = Coord.fromJson(json['coord']);
//     weather = List<Weather>.from(
//       json['weather'].map((item) => Weather.fromJson(item)),
//     );
//     // (json['weather'] as List)
//     //     .map((item) => Weather.fromJson(item))
//     //     .toList();
//     base = json['base'];
//     main = Main.fromJson(json['main']);
//     visibility = json['visibility'];
//     wind = Wind.fromJson(json['wind']);
//     clouds = Clouds.fromJson(json['clouds']);
//     dt = json['dt'];
//     sys = Sys.fromJson(json['sys']);
//     timezone = json['timezone'];
//     id = json['id'];
//     name = json['name'];
//     cod = json['cod'];
//   }
// }

// class Clouds {
//   int? all;

//   Clouds({this.all});

//   Clouds.fromJson(Map<String, dynamic> json) {
//     all = json['all'];
//   }
// }

// class Coord {
//   double? lon;
//   double? lat;

//   Coord({this.lon, this.lat});
//   Coord.fromJson(Map<String, dynamic> json) {
//     lon = json['lon'];
//     lat = json['lat'];
//   }
// }

// class Main {
//   double? temp;
//   double? feelsLike;
//   double? tempMin;
//   double? tempMax;
//   int? pressure;
//   int? humidity;
//   int? seaLevel;
//   int? grndLevel;

//   Main({
//     this.temp,
//     this.feelsLike,
//     this.tempMin,
//     this.tempMax,
//     this.pressure,
//     this.humidity,
//     this.seaLevel,
//     this.grndLevel,
//   });

//   Main.fromJson(Map<String, dynamic> json) {
//     temp = json['temp'];
//     feelsLike = json['feels_like'];
//     tempMin = json['temp_min'];
//     tempMax = json['temp_max'];
//     pressure = json['pressure'];
//     humidity = json['humidity'];
//     seaLevel = json['sea_level'];
//     grndLevel = json['grnd_level'];
//   }
// }

// class Sys {
//   String? country;
//   int? sunrise;
//   int? sunset;

//   Sys({this.country, this.sunrise, this.sunset});

//   Sys.fromJson(Map<String, dynamic> json) {
//     country = json['country'];
//     sunrise = json['sunrise'];
//     sunset = json['sunset'];
//   }
// }

// class Weather {
//   int? id;
//   String? main;
//   String? description;
//   String? icon;

//   Weather({this.id, this.main, this.description, this.icon});

//   Weather.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     main = json['main'];
//     description = json['description'];
//     icon = json['icon'];
//   }
// }

// class Wind {
//   double? speed;
//   int? deg;
//   double? gust;

//   Wind({this.speed, this.deg, this.gust});

//   Wind.fromJson(Map<String, dynamic> json) {
//     speed = json['speed'];
//     deg = json['deg'];
//     gust = json['gust'];
//   }
// }
