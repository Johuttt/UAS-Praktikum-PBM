class Kontak {
  late int? id;
  late String nama;
  late String nomor;

  Kontak({this.id, required this.nama, required this.nomor});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'nomor': nomor,
    };
  }

  Kontak.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nama = map['nama'];
    nomor = map['nomor'];
  }
}
