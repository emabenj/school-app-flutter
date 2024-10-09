class APIConstants {
  // static const baseUrl = "http://localhost:8000/colegio";
  static const port = "8000";
  static const ip = "192.168.18.6";//127.0.0.1
  static const domain = "$ip:$port/";
  static const url = "http://$ip:$port";
  static const baseUrl = "http://${domain}colegio";
  static const schoolUrl = "api/v1/";
  static const tSecretAPIkey = "";
}
