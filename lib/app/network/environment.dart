enum Environment { staging, uat, production }

const Environment activeProfile = Environment.staging;

String getBaseUrl() {
  switch (activeProfile) {
    case Environment.staging:
      return "https://manush-shop.onrender.com/api/v1";
    case Environment.uat:
      return "";
    case Environment.production:
      return "";
  }
}
