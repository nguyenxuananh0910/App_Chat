enum Environment {
  development,
  production,
  staging;

  bool get isDevelopment => this == Environment.development;
  bool get isProduction => this == Environment.production;
  bool get isStaging => this == Environment.staging;
}
