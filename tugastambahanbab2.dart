// Enum untuk Status Mahasiswa
enum StatusMahasiswa { aktif, cuti, alumni }

// Abstract class untuk Kehadiran
abstract class Kehadiran {
  void absensi();
  void izin();
}

// Mixin untuk menambah fitur kegiatan ekstra kurikuler
mixin KegiatanEkstrakurikuler {
  void ikutKegiatan(String kegiatan) {
    print('Ikut dalam kegiatan ekstrakurikuler $kegiatan');
  }
}

// Kelas dasar Mahasiswa
class Mahasiswa {
  String nama;
  String _npm;
  String jurusan;
  String alamat;
  StatusMahasiswa status;
  double nilaiAkhir;

  // Constructor dengan positional argument untuk nama, npm, jurusan, dan alamat
  Mahasiswa(this.nama, this._npm, this.jurusan, this.alamat, this.status, this.nilaiAkhir);

  // Getter dan Setter untuk NPM dengan validasi panjang karakter
  String get npm => _npm;
  set npm(String value) {
    if (value.length == 8) {
      _npm = value;
    } else {
      print('NPM harus 8 karakter.');
    }
  }

  // Metode belajar
  void belajar() {
    print('$nama sedang belajar di jurusan $jurusan.');
  }

  // Metode cek status mahasiswa
  void cekStatus() {
    print('$nama memiliki status $status');
  }

  // Metode untuk update nilai akhir
  void updateNilai(double nilaiBaru) {
    nilaiAkhir = nilaiBaru;
    print('Nilai akhir $nama telah diperbarui menjadi $nilaiAkhir');
  }

  // Metode untuk cek kelulusan
  void cekKelulusan() {
    if (nilaiAkhir >= 60) {
      print('$nama telah lulus.');
    } else {
      print('$nama belum lulus.');
    }
  }
}

// Kelas turunan MahasiswaAktif dengan inheritance dari Mahasiswa dan implementasi Kehadiran serta mixin KegiatanEkstrakurikuler
class MahasiswaAktif extends Mahasiswa with KegiatanEkstrakurikuler implements Kehadiran {
  int semester;

  // Constructor dengan inheritance dari superclass Mahasiswa
  MahasiswaAktif(String nama, String npm, String jurusan, String alamat, StatusMahasiswa status, double nilaiAkhir, this.semester)
      : super(nama, npm, jurusan, alamat, status, nilaiAkhir);

  // Implementasi metode absensi dari Kehadiran
  @override
  void absensi() {
    print('$nama telah hadir di kelas.');
  }

  // Implementasi metode izin dari Kehadiran
  @override
  void izin() {
    print('$nama izin tidak hadir.');
  }

  // Metode khusus untuk mengikuti ujian
  void mengikutiUjian() {
    print('$nama sedang mengikuti ujian semester $semester.');
  }
}

// Fungsi utama untuk menjalankan program
void main() {
  // Membuat objek mahasiswa
  var mahasiswa = MahasiswaAktif('Arhy', '87654321', 'Informatika', 'JL. Jati', StatusMahasiswa.aktif, 75.5, 3);

  // Memanggil berbagai metode untuk menampilkan informasi
  mahasiswa.belajar();
  mahasiswa.absensi();
  mahasiswa.izin();
  mahasiswa.mengikutiUjian();
  mahasiswa.ikutKegiatan('Paduan Suara');
  mahasiswa.cekStatus();
  mahasiswa.updateNilai(82.0);
  mahasiswa.cekKelulusan();
}