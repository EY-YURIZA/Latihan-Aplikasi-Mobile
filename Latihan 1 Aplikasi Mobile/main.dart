void main() {
  //  data menu kedai kopinya
  String namaKopi = 'Kopi Susu Gula Aren';
  int jumlahCup = 3;
  double jamBuka = 08.30;
  bool bukaToko = true;

  print(namaKopi);
  print(jumlahCup);
  print(jamBuka);
  print(bukaToko);
  
  // nyobain gabungin teks sama variabel pake dolar
  print('Pesanan $namaKopi, dibeli sebanyak $jumlahCup cup');

  // ini tipe data (?) yg boleh kosong (dikasih tanda tanya)
  String? catatanPelanggan = 'Esnya sedikit, gulanya normal';
  print(catatanPelanggan);
  catatanPelanggan = null; 
  print(catatanPelanggan);

  // nyobain tanda tanya dua (??) buat ngasih teks default kalo datanya null
  String hasilCatatan = catatanPelanggan ?? 'Ga ada catatan khusus';
  print(hasilCatatan);

  // late disiapin dulu variabelnya tapi diisinya nanti
  late String namaKasir;
  namaKasir = 'Adit';
  print(namaKasir);

  // pake final sama const biar datanya paten ga bisa diubah
  final String idStruk = 'Pesanan-0211';
  print(idStruk);
  const String namaKedai = 'Kedai Kopi Mahasiswa Global';
  print(namaKedai.toUpperCase()); // dicetak pake huruf gede semua

  //  hitungan dasar buat mnentukan harga
  int hargaKopi = 15000;
  int ongkir = 5000;
  print(hargaKopi + ongkir); // langsung ditambahin pas di-print

  // bikin list menu cemilan
  List<String> menuCemilan = [
    'Roti Bakar',
    'Kentang Goreng',
    'Pisang Goreng',
  ];
  menuCemilan.add('Cireng Bumbu Rujak'); // nambahin menu baru 
  print(menuCemilan);

 // (set) buat kategori, isikan data yang unik saja dari awal biar ga kena warning
  Set<String> kategoriMenu = {'Kopi', 'Cemilan'};
  print(kategoriMenu);
  // pake map biar bisa nyimpen data kaya biodata
  Map<String, dynamic> dataPesanan = {
    'NomorMeja': 4,
    'NamaPemesan': 'Adit',
    'TotalCup': 3,
    'TotalBayar': 50000.00,
    'MenuFavorit': 'Kopi Susu',
    'MemberAktif': true,
  };
  print(dataPesanan);
}