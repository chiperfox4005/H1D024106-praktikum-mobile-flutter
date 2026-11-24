
import '../helpers/api.dart';
import '../helpers/api_url.dart';

class ProdukBloc {
  Future<dynamic> getProduks() async {
    return await Api().get(ApiUrl.produk);
  }

  Future<dynamic> getProduk(int id) async {
    return await Api().get(ApiUrl.detailProduk(id));
  }

  Future<dynamic> createProduk(Map<String, dynamic> data) async {
    return await Api().post(ApiUrl.produk, data);
  }

  Future<dynamic> updateProduk(
    int id,
    Map<String, dynamic> data,
  ) async {
    return await Api().put(ApiUrl.detailProduk(id), data);
  }

  Future<dynamic> deleteProduk(int id) async {
    return await Api().delete(ApiUrl.detailProduk(id));
  }
}
