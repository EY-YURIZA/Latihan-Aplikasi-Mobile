# Tugas 2 Aplikasi Mobile - E-Wallet

**Nama:** Aditya Ramadhan Khiang  
**NIM:** 1124160084  

---

### 1. Problem Statement
Sistem membutuhkan fitur pembayaran e-wallet yang mampu memotong saldo secara otomatis, namun harus melewati validasi keamanan terlebih dahulu (pengecekan PIN dan ketersediaan limit transaksi).

### 2. Actor
| Peran | Keterangan |
| :--- | :--- |
| **Pengguna** | Pengguna akhir aplikasi e-wallet. |

### 3. Input & Output
| Aspek | Data yang Diproses |
| :--- | :--- |
| **Input** | Memasukkan `pin` dan `nominal` belanja. |
| **Output** | Pesan keterangan transaksi (sukses/gagal). |

### 4. Functional Requirement
Sistem dapat memotong saldo jika PIN benar, sisa limit harian masih cukup, dan saldo di dompet tidak kurang dari nominal belanja (tidak boleh minus).

### 5. Business Rules
| Kode | Aturan Sistem |
| :--- | :--- |
| **BR-01** | Masukin pin salah 3 kali berturut-turut, akun langsung diblokir. |
| **BR-02** | Limit transaksi maksimal 2 juta sehari. |
| **BR-03** | Saldo ga boleh kurang dari nominal yang mau dibayar. |

### 6. Decomposition

```text
prosesBayar
├── cekPin
│   ├── cek validasi input PIN dengan pinAsli
│   └── catat jumlah salah, blokir jika >= 3
├── cekLimit
│   └── cek apakah transaksiHariIni + nominalBayar > 2 juta
├── cekSaldo
│   └── cek apakah saldoDompet < nominalBayar
└── potong saldo
    ├── saldoDompet dikurangi nominalBayar
    └── transaksiHariIni ditambah nominalBayar
```

### 7. Pattern Recognition
| Metode | Implementasi |
| :--- | :--- |
| **Perulangan (Loop)** | Pake perulangan `for` buat ngejalanin proses bayar banyak jajanan sekaligus. |

### 8. Abstraction
| Komponen | Penamaan Variabel |
| :--- | :--- |
| **Data Akun & Dompet** | `saldoDompet`, `pinAsli`, `akunKeblokir` |

### 9. Algorithm
| Urutan | Proses Eksekusi |
| :---: | :--- |
| **1** | Masukin PIN dan nominal pembayaran. |
| **2** | Cek apakah akun terblokir. |
| **3** | Cek apakah PIN benar. |
| **4** | Cek apakah sisa limit masih ada. |
| **5** | Cek apakah saldo dompet cukup. |
| **6** | Kalo syarat aman semua, potong saldo dompet. |

### 10. Flowchart 

```text
[ MULAI ]
    |
    v
( Input PIN & Nominal )
    |
    v
[ Cek: Akun Aman? PIN Benar? Limit Cukup? Saldo Cukup? ] --(Ada yg Salah)--> ( GAGAL )
    |
 (Aman Semua)
    |
    v
[ Potong Saldo Dompet ]
    |
    v
( BERHASIL )
    |
    v
[ SELESAI ]
```

### 11. Pseudocode

```text
jika akun diblokir = gagal.
jika pin salah = tambah catetan salah, kalo sampe 3x blokir akun.
jika nominal + pengeluaran hari ini > 2 juta = gagal limit.
jika saldo < nominal = gagal kurang duit.
kalo aman semua = saldo dikurang nominal.
```


### 12. Simulasi Uji Kasus (Trace Table)

| Kasus Uji | Nominal Bayar | Input PIN | Evaluasi Kondisi Program | Status Transaksi | Sisa Saldo |
| :---: | :--- | :---: | :--- | :--- | :--- |
| **Kasus 1** | Rp 500.000 | `123456` | PIN benar, Limit aman, Saldo cukup | **Berhasil** | Rp 4.500.000 |
| **Kasus 2** | Rp 1.600.000 | `123456` | Limit jebol! (500k + 1.6jt > 2jt) | **Gagal (Limit Habis)** | Rp 4.500.000 |
| **Kasus 3** | Rp 10.000.000 | `123456` | Limit aman, tapi saldo cuma 4.5jt | **Gagal (Saldo Kurang)**| Rp 4.500.000 |
| **Kasus 4** | Rp 10.000 | `111111` | PIN salah (Batas salah = 1) | **Gagal (PIN Salah)** | Rp 4.500.000 |
| **Kasus 5** | Rp 10.000 | `222222` | PIN salah (Batas salah = 2) | **Gagal (PIN Salah)** | Rp 4.500.000 |
| **Kasus 6** | Rp 10.000 | `333333` | PIN salah (Batas = 3). Akun diblokir! | **Gagal (PIN Salah)** | Rp 4.500.000 |
| **Kasus 7** | Rp 10.000 | `123456` | PIN benar, tapi akun sudah keblokir | **Gagal (Terblokir)** | Rp 4.500.000 |
| **Kasus 8** | *List (3x)* | `123456` | Akun di-reset. Jajan 15k, 20k, 5k | **Berhasil** | Rp 4.460.000 |