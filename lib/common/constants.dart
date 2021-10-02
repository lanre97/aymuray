class NASAPowerParameters{
  static const String CLEAR_SKY_DAYS = "CLRSKY_DAYS";
  static const String CLOUD_AMOUNT = "CLOUD_AMT";
  static const String CLOUD_AMOUNT_AT_DAYTIME = "CLOUD_AMT_DAY";
  static const String CLOUD_AMOUNT_AT_NIGHTTIME = "CLOUD_AMT_NIGHT";
  static const String COOLING_DEGREE_DAYS_ABOVE_0_C = "CDD0";
  static const String COOLING_DEGREE_DAYS_ABOVE_10_C = "CDD10";
  static const String COOLING_DEGREE_DAYS_ABOVE_18_3_C = "CDD18_3";
  static const String CORRECTED_ATHMOSPHERIC_PRESSURE = "PSC";
  static const String CORRECTED_WIND_SPEED = "WSC";
  static const String DIRECT_ILLUMINANCE = "DIRECT_ILLUMINANCE";
  static const String EARTH_SKIN_TEMPERATURE = "TS";
  static const String FROST_DAYS = "FROST_DAYS";
  static const String GLOBAL_ILLUMINANCE = "GLOBAL_ILLUMINANCE";
  static const String HEATING_DEGREE_DAYS_BELOW_0_C = "HDD0";
  static const String HEATING_DEGREE_DAYS_BELOW_10_C = "HDD10";
  static const String HEATING_DEGREE_DAYS_BELOW_18_3_C = "HDD18_3";
  static const String MIDDAY_INSOLATION_INCIDENT_MAXIMUM = "MIDDAY_INSOL_MAX";
  static const String PROFILE_SOIL_MOISTURE = "GWETPROF";
  static const String PRECIPITATION_CORRECTED = "PRECTOTCORR";
  static const String REALATIVE_HUMIDITY_AT_2_METERS = "RH2M";
  static const String ROOT_ZONE_SOIL_WETNESS = "GWETROOT";
  static const String SPECIFIC_HUMIDITY_AT_2_METERS = "QV2M";
  static const String SURFACE_AIR_DENSITY = "RHOA";
  static const String TEMPERATURE_AT_2_METERS = "T2M";
  static const String TEMPERATURE_AT_2_METERS_MAXIMUM = "T2M_MAX";
  static const String TEMPERATURE_AT_2_METERS_MAXIMUM_AVERAGE = "T2M_MAX_AVG";
  static const String TEMPERATURE_AT_2_METERS_MINIMUM = "T2M_MIN";
  static const String TEMPERATURE_AT_2_METERS_MINIMUM_AVERAGE = "T2M_MIN_AVG";
  static const String TOTAL_COLUMN_PRECIPITABLE_WATER = "TQV";
  static const String WIND_SPEED_AT_2_METERS = "WS2M";
  static const String WIND_SPEED_AT_2_METERS_MAXIMUM = "WS2M_MAX";
  static const String WIND_SPEED_AT_2_METERS_MAXIMUM_AVERAGE = "WS2M_MAX_AVG";
  static const String WIND_SPEED_AT_2_METERS_MINIMUM = "WS2M_MIN";
  static const String WIND_SPEED_AT_2_METERS_MINIMUM_AVERAGE = "WS2M_MIN_AVG";
}

class NASAPowerCommunities{
  static const String AGROCLIMATOLOGY = "AG";
  static const String RENEWABLE_ENERGY = "RE";
  static const String SUSTAINABLE_BUILDINGS = "SB";
}

class NASAPowerServices{
  static const CLIMATOLOGY = "climatology";
  static const MONTHLY = "monthly";
  static const DAILY = "daily";
  static const HOURLY = "hourly";
}

class Location {
  final double longitude;
  final double latitude;
  const Location(this.latitude,this.longitude);
}


