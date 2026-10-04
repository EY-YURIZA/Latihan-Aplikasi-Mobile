// contoh data e-wallet
String pinAsli = '123456';
double saldoDompet = 5000000.0;
double transaksiHariIni = 0.0;
int batasSalahPin = 0;
bool akunKeblokir = false;

// ngecek pin bener apa salah (BR-01)
bool cekPin(String inputPin) {
  if (inputPin == pinAsli) {
    batasSalahPin = 0; // kalo bener, jatah salahnya di-reset
    return true;
  } else {
    batasSalahPin++; // kalo salah, catatan salahnya nambah
    if (batasSalahPin >= 3) {
      akunKeblokir = true; // kalo udh 3 kali, langsung blokir akunnya
    }
    return false;
  }
}
// ngecek sisa limit harian 2 juta (BR-02)
bool cekLimit(double nominalBayar) {
  if ((transaksiHariIni + nominalBayar) > 2000000) {
    return false; // kalo lewat 2 juta, berarti jebol limitnya
  }
  return true; // masih aman
}

// ngecek duit di dompet cukup atau engga (BR-03)
bool cekSaldo(double nominalBayar) {
  if (saldoDompet < nominalBayar) {
    return false; // kurang duitnya
  }
  return true; // cukup
}

// fungsi utamanya buat ngurusin pembayaran
String prosesBayar(String inputPin, double nominalBayar) {
  // cek dulu akunnya lagi diblokir atau engga
  if (akunKeblokir == true) {
    return 'Gagal: Akun Terblokir!';
  }
  // cek pin dulu  (BR-01)
  if (cekPin(inputPin) == false) {
    return 'Gagal: PIN Salah. (Kesalahan ke-$batasSalahPin)';
  }
  // cek limit harian (BR-02)
  if (cekLimit(nominalBayar) == false) {
    return 'Gagal: Limit harian 2 juta sudah habis.';
  }
  // cek cukup atau ga saldo nya (BR-03)
  if (cekSaldo(nominalBayar) == false) {
    return 'Gagal: Saldo tidak cukup.';
  }
  // kalo semua syarat di atas lolos, baru saldo dipotong
  saldoDompet = saldoDompet - nominalBayar;
  transaksiHariIni = transaksiHariIni + nominalBayar;
  return 'Berhasil: Pembayaran Rp$nominalBayar sukses. Sisa saldo: Rp$saldoDompet';
}
void main() {
  // ngetes bayar normal biasa
  print(prosesBayar('123456', 500000));
  // ngetes kalo jajan ngelebihi limit 2 juta
  print(prosesBayar('123456', 1600000));
  // ngetes kalo saldonya ga cukup buat bayar
  print(prosesBayar('123456', 10000000));
  // ngetes sengaja salah masukin pin sampe 3 kali beruntun
  print(prosesBayar('111111', 10000)); // salah pertama
  print(prosesBayar('222222', 10000)); // salah kedua
  print(prosesBayar('333333', 10000)); // salah ketiga (langsung keblokir)
  // ngetes mau bayar pas kondisi akunnya udah terlanjur keblokir
  print(prosesBayar('123456', 10000));
  // coba reset dulu , biar status blokirnya buat ngetes  list di bawah agar bisa digunakan
  akunKeblokir = false; 
  batasSalahPin = 0;
  // contoh pake list untuk harga jajanan
  List<double> daftarJajanan = [15000, 20000, 5000];
  // pake perulangan for buat bayar jajanannya satu-satu
  for (int i = 0; i < daftarJajanan.length; i++) {
    print(prosesBayar('123456', daftarJajanan[i]));
  }
}