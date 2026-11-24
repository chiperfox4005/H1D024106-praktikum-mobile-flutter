class ApiUrl {
  static const String baseUrl = 'http://127.0.0.1:8080';

  static const String registrasi = '$baseUrl/registrasi';
  static const String login = '$baseUrl/login';
  static const String produk = '$baseUrl/produk';

  static String detailProduk(int id) => '$produk/$id';
}