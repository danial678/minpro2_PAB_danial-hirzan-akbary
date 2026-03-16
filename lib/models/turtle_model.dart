class TurtleModel {
  final String? id;
  final String namaPenyu;
  final String lokasiSarang;
  final int jumlahTelur;
  final DateTime tanggalBertelur;
  final String statusTelur;
  final int jumlahTukikDilepas;
  final String? createdAt;

  TurtleModel({
    this.id,
    required this.namaPenyu,
    required this.lokasiSarang,
    required this.jumlahTelur,
    required this.tanggalBertelur,
    required this.statusTelur,
    required this.jumlahTukikDilepas,
    this.createdAt,
  });

  factory TurtleModel.fromJson(Map<String, dynamic> json) {
    return TurtleModel(
      id: json['id'],
      namaPenyu: json['nama_penyu'],
      lokasiSarang: json['lokasi_sarang'],
      jumlahTelur: json['jumlah_telur'],
      tanggalBertelur: DateTime.parse(json['tanggal_bertelur']),
      statusTelur: json['status_telur'],
      jumlahTukikDilepas: json['jumlah_tukik_dilepas'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_penyu': namaPenyu,
      'lokasi_sarang': lokasiSarang,
      'jumlah_telur': jumlahTelur,
      'tanggal_bertelur': tanggalBertelur.toIso8601String(),
      'status_telur': statusTelur,
      'jumlah_tukik_dilepas': jumlahTukikDilepas,
    };
  }
}