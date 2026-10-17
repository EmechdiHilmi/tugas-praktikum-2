int hitungTotal(List<int> harga) {
  int total = 0;
  for (var h in harga) {
    total += h;
  }
  return total;
}

double hitungPajak(double total) => total * 10 / 100;

void main() {
  const String namaToko = 'Toko Metro';
  final String namaPelanggan = 'Budi';
  bool isMember = true;
  String? kodeVoucher; // Dibiarkan null

  List<String> namaBarang = ['Pensil', 'Buku', 'Tas'];
  List<int> hargaBarang = [5000, 15000, 120000];

  int total = hitungTotal(hargaBarang);

  double diskon = 0;
  if (isMember && total >= 10000) {
    diskon = total * 10 / 100;
  }

  double pajak = hitungPajak((total - diskon).toDouble());
  double bayar = (total - diskon) + pajak;
  double uangBayar = 200000;
  double kembalian = uangBayar - bayar;
  
  String level;
  switch (total) {
    case >= 200000:
      level = 'Gold';
      break;
    case >= 100000:
      level = 'Silver';
      break;
    default:
      level = 'Reguler';
      break;
  }


  print('=== $namaToko ===');
  print('Pelanggan: $namaPelanggan');
  
  for (int i = 0; i < namaBarang.length; i++) {
    print('${i + 1}. ${namaBarang[i]} Rp ${hargaBarang[i]}');
  }

  print('Total\t: Rp $total');
  print('Diskon\t: Rp $diskon');
  print('Pajak\t: Rp $pajak');
  print('Bayar\t: Rp $bayar');
  print('Voucher : ${kodeVoucher ?? "Tidak ada voucher"}');
  print('Level\t: $level');
  print('Kembalian\tRp $kembalian');
}