import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kafe Nusantara',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const HalamanUtama(),
    );
  }
}

// Pembungkus 3 halaman menu, pindah halaman lewat navigasi bawah
class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const [
          // Halaman 1: Spaghetti Bolognese
          DetailMenuPage(
            gambar: 'assets/images/spaghetti.jpg',
            nama: 'Spaghetti Bolognese',
            hargaSatuan: 32000,
            rating: '5.0',
            waktu: '15 menit',
            kalori: '700 kal',
            deskripsi:
                'Spaghetti al dente disiram saus bolognese kental dari daging sapi '
                'cincang, tomat segar, bawang bombay, dan rempah Italia yang '
                'dimasak perlahan. Rasanya gurih, sedikit manis asam, lalu '
                'ditaburi keju parmesan dan daun basil.',
          ),
          // Halaman 2: Spaghetti Carbonara
          DetailMenuPage(
            gambar: 'assets/images/spaghetti_c.jpg',
            nama: 'Spaghetti Carbonara',
            hargaSatuan: 35000,
            rating: '4.9',
            waktu: '20 menit',
            kalori: '650 kal',
            deskripsi:
                'Spaghetti dengan saus krim telur yang lembut dan gurih, '
                'dipadukan potongan daging asap yang renyah, keju parmesan, '
                'dan taburan lada hitam serta peterseli segar.',
          ),
          // Halaman 3: Spaghetti Aglio Olio
          DetailMenuPage(
            gambar: 'assets/images/spaghetti_a.jpg',
            nama: 'Spaghetti Aglio Olio',
            hargaSatuan: 38000,
            rating: '4.8',
            waktu: '15 menit',
            kalori: '550 kal',
            deskripsi:
                'Spaghetti yang ditumis dengan minyak zaitun, bawang putih, '
                'dan cabai kering, lalu disajikan bersama udang segar dan '
                'daun peterseli. Rasanya harum, gurih, dan sedikit pedas.',
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu),
            label: 'Bolognese',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu),
            label: 'Carbonara',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu),
            label: 'Aglio Olio',
          ),
        ],
      ),
    );
  }
}

// 1. Diubah menjadi StatefulWidget agar bisa handle state jumlah pesanan, catatan, dan favorit
class DetailMenuPage extends StatefulWidget {
  final String gambar;
  final String nama;
  final int hargaSatuan;
  final String rating;
  final String waktu;
  final String kalori;
  final String deskripsi;

  const DetailMenuPage({
    super.key,
    required this.gambar,
    required this.nama,
    required this.hargaSatuan,
    required this.rating,
    required this.waktu,
    required this.kalori,
    required this.deskripsi,
  });

  @override
  State<DetailMenuPage> createState() => _DetailMenuPageState();
}

class _DetailMenuPageState extends State<DetailMenuPage> {
  bool isFavorite = false;
  int jumlahPesanan = 1;
  String catatanPesanan = '';

  // Fungsi bantu format rupiah
  String formatRupiah(int angka) {
    final s = angka.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buffer.write('.');
      buffer.write(s[i]);
    }
    return 'Rp $buffer';
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  void tambahJumlah() {
    setState(() {
      jumlahPesanan++;
    });
  }

  void kurangiJumlah() {
    if (jumlahPesanan > 1) {
      setState(() {
        jumlahPesanan--;
      });
    }
  }

  Widget _itemInfo(IconData icon, Color warnaIkon, String teks) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: warnaIkon, size: 26),
        const SizedBox(height: 4),
        Text(teks, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final int totalHarga = widget.hargaSatuan * jumlahPesanan;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Menu'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar menu pake asset yang lu punya + error handling
            Image.asset(
              widget.gambar,
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 220,
                  color: Colors.brown.shade100,
                  alignment: Alignment.center,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.broken_image, size: 60, color: Colors.brown),
                      SizedBox(height: 8),
                      Text('Gambar asset tidak ditemukan', style: TextStyle(color: Colors.brown)),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama menu & Harga satuan
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.nama,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        formatRupiah(widget.hargaSatuan),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Kotak info (Rating, Waktu, Kalori)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFEBE9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _itemInfo(Icons.star, Colors.amber, widget.rating),
                        _itemInfo(Icons.schedule, Colors.brown, widget.waktu),
                        _itemInfo(Icons.local_fire_department, Colors.deepOrange, widget.kalori),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Deskripsi
                  const Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.deskripsi,
                    style: const TextStyle(fontSize: 14, height: 1.5, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),

                  // Jumlah Pesanan
                  const Text(
                    'Jumlah Pesanan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton.outlined(
                        onPressed: kurangiJumlah,
                        icon: const Icon(Icons.remove),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          '$jumlahPesanan',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton.outlined(
                        onPressed: tambahJumlah,
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Catatan Pesanan
                  const Text(
                    'Catatan Pesanan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Contoh: tidak pakai pedas, extra keju',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        catatanPesanan = value;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  Text(
                    catatanPesanan.isEmpty
                        ? 'Catatan: -'
                        : 'Catatan: $catatanPesanan',
                    style: const TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Tombol Pesan dengan total harga dinamis di bawah
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Pesanan $jumlahPesanan porsi ${widget.nama} berhasil dibuat (${formatRupiah(totalHarga)})'
                    '${catatanPesanan.isNotEmpty ? " [Catatan: $catatanPesanan]" : ""}',
                  ),
                ),
              );
            },
            child: Text(
              'Pesan - ${formatRupiah(totalHarga)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}