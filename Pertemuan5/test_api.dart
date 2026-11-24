
import 'package:flutter/material.dart';
import 'bloc/produk_bloc.dart';

void main() {
  runApp(const TestApiApp());
}

class TestApiApp extends StatelessWidget {
  const TestApiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pengujian Helper API',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ProdukPage(),
    );
  }
}

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  final ProdukBloc produkBloc = ProdukBloc();

  late Future<dynamic> futureProduk;

  @override
  void initState() {
    super.initState();
    futureProduk = produkBloc.getProduks();
  }

  void refreshProduk() {
    setState(() {
      futureProduk = produkBloc.getProduks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: refreshProduk,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<dynamic>(
        future: futureProduk,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Gagal mengambil data produk',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(snapshot.error.toString()),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: refreshProduk,
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          final response = snapshot.data;

          if (response is! Map || response['data'] is! List) {
            return const Center(
              child: Text('Format respons API tidak sesuai'),
            );
          }

          final List produkList = response['data'];

          if (produkList.isEmpty) {
            return const Center(
              child: Text('Belum ada data produk'),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green),
                    const SizedBox(width: 8),
                    Text(
                      'Berhasil mengambil ${produkList.length} produk',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: produkList.length,
                  itemBuilder: (context, index) {
                    final produk = produkList[index];

                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(produk['id'].toString()),
                        ),
                        title: Text(
                          produk['nama_produk'].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Kode: ${produk['kode_produk']}\n'
                          'Harga: Rp ${produk['harga']}',
                        ),
                        isThreeLine: true,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
