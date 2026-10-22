class Karakter {
  String nama;
  int _healthPoint = 100;

  Karakter({required this.nama});

  int get sisaDarah => _healthPoint;

  void sapa() {
    print("Halo, saya $nama, siap bertarung!");
  }

  void terimaSerangan(int damage) {
    print("$nama diserang! Menerima $damage damage.");
    _healthPoint -= damage;
    if (_healthPoint <= 0) {
      _healthPoint = 0;
      print("$nama telah gugur.");
    } else {
      print("Sisa darah $nama: $_healthPoint");
    }
  }

  void pulihkanDarah(int jumlah) {
    if (_healthPoint == 0) {
      print("$nama sudah gugur dan tidak bisa dipulihkan.");
      return;
    }
    
    _healthPoint += jumlah;
    if (_healthPoint > 100) {
      _healthPoint = 100;
    }
    print("Darah $nama pulih menjadi $_healthPoint.");
  }
}

class Healer extends Karakter {
  Healer({required super.nama});

  void heal(Karakter target) {
    print("$nama merapal mantra penyembuh ke ${target.nama}!");
    target.pulihkanDarah(30);
  }
}

void main() {
  var goblin = Karakter(nama: "Goblin");
  var layla = Karakter(nama: "Layla");
  var estes = Healer(nama: "Estes");

  print("=== PERTARUNGAN DIMULAI ===");
  estes.sapa();
  layla.sapa();
  
  layla.terimaSerangan(50);
  
  estes.heal(layla);
  estes.heal(layla);
  
  goblin.terimaSerangan(40);
  goblin.terimaSerangan(70);
  
  estes.heal(goblin);
  
  print("Cek radar: darah Goblin tersisa ${goblin.sisaDarah}");
}