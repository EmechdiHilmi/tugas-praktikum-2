import 'package:flutter/material.dart';
 
void main() {
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HalamanUtama(),
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
            harga: 'Rp 32.000',
            rating: '5.0',
            waktu: '15 menit',
            kalori: '700 kal',
            deskripsi:
                'Spaghetti al dente disiram saus bolognese kental dari daging sapi '
                'cincang, tomat segar, bawang bombay, dan rempah Italia yang '
                'dimasak perlahan. Rasanya gurih, sedikit manis asam, lalu '
                'ditaburi keju parmesan dan daun basil. Cocok untuk makan '
                'siang yang mengenyangkan.',
          ),
          // Halaman 2: Spaghetti Carbonara
          DetailMenuPage(
            gambar: 'assets/images/spaghetti_c.jpg',
            nama: 'Spaghetti Carbonara',
            harga: 'Rp 35.000',
            rating: '4.9',
            waktu: '20 menit',
            kalori: '650 kal',
            deskripsi:
                'Spaghetti dengan saus krim telur yang lembut dan gurih, '
                'dipadukan potongan daging asap yang renyah, keju parmesan, '
                'dan taburan lada hitam serta peterseli segar. Teksturnya '
                'creamy dengan rasa asin gurih yang pas, nikmat disantap '
                'selagi hangat.',
          ),
          // Halaman 3: Spaghetti Aglio Olio
          DetailMenuPage(
            gambar: 'assets/images/spaghetti_a.jpg',
            nama: 'Spaghetti Aglio Olio',
            harga: 'Rp 38.000',
            rating: '4.8',
            waktu: '15 menit',
            kalori: '550 kal',
            deskripsi:
                'Spaghetti yang ditumis dengan minyak zaitun, bawang putih, '
                'dan cabai kering, lalu disajikan bersama udang segar dan '
                'daun peterseli. Rasanya harum, gurih, dan sedikit pedas, '
                'ringan tapi tetap memuaskan.',
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
 
// Satu halaman detail menu (layout sama untuk ketiga menu)
class DetailMenuPage extends StatelessWidget {
  final String gambar;
  final String nama;
  final String harga;
  final String rating;
  final String waktu;
  final String kalori;
  final String deskripsi;
 
  const DetailMenuPage({
    super.key,
    required this.gambar,
    required this.nama,
    required this.harga,
    required this.rating,
    required this.waktu,
    required this.kalori,
    required this.deskripsi,
  });
 
  // Satu item info: Icon di atas, Text di bawah (Column)
  Widget _itemInfo(IconData icon, Color warnaIkon, String teks) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: warnaIkon, size: 28),
        const SizedBox(height: 4),
        Text(teks),
      ],
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Menu')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tugas 1: gambar menu
            Image.asset(
              gambar,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 250,
                  color: Colors.grey.shade300,
                  alignment: Alignment.center,
                  child: const Text('Gambar tidak ditemukan'),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
 
                  // Tugas 2: nama menu (kiri) dan harga (kanan)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        nama,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        harga,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF795548),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
 
                  // Tugas 3: kotak info (3 ikon + teks)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFEBE9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _itemInfo(Icons.star, Colors.amber, rating),
                        _itemInfo(
                            Icons.schedule, const Color(0xFF795548), waktu),
                        _itemInfo(Icons.local_fire_department,
                            Colors.deepOrange, kalori),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
 
                  // Tugas 4: judul dan paragraf deskripsi
                  const Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    deskripsi,
                    style: const TextStyle(fontSize: 14, height: 1.5),
                  ),
                  const SizedBox(height: 16),
 
                  // Tugas 5: tombol pesan selebar layar
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF795548),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Pesan Sekarang'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 


