import 'package:mobilesurvey/utilities/parse_utils.dart';

class NikDataModel {
  final String namaLengkap;
  final String statusHubunganKeluarga;
  final String jenisPekerjaan;
  final String tempatLahir;
  final String statusKawin;
  final String golonganDarah;
  final String nikIbu;
  final String nomorAktaKawin;
  final String jenisKelamin;
  final String tanggalCerai;
  final String nomorKK;
  final String nik;
  final String kabupatenName;
  final String namaLengkapAyah;
  final String nomorRw;
  final String kecamatanName;
  final String nomorRt;
  final String nomorKelurahan;
  final String nomorKecamatan;
  final String alamat;
  final String nikAyah;
  final String nomorProvinsi;
  final String namaLengkapIbu;
  final String nomorAktaCerai;
  final String provinsiName;
  final String nomorKabupaten;
  final String tanggalLahir;
  final String kelurahanName;
  final String pendidikanAkhir;
  final String tanggalKawin;

  NikDataModel(
      {this.tanggalKawin,
        this.pendidikanAkhir,
        this.namaLengkap,
        this.statusHubunganKeluarga,
        this.jenisPekerjaan,
        this.tempatLahir,
        this.statusKawin,
        this.golonganDarah,
        this.nikIbu,
        this.nomorAktaKawin,
        this.jenisKelamin,
        this.tanggalCerai,
        this.nomorKK,
        this.nik,
        this.kabupatenName,
        this.namaLengkapAyah,
        this.nomorRw,
        this.kecamatanName,
        this.nomorRt,
        this.nomorKelurahan,
        this.nomorKecamatan,
        this.alamat,
        this.nikAyah,
        this.nomorProvinsi,
        this.namaLengkapIbu,
        this.nomorAktaCerai,
        this.provinsiName,
        this.nomorKabupaten,
        this.tanggalLahir,
        this.kelurahanName});

  factory NikDataModel.fromJson(Map<String, dynamic> json) {
    return NikDataModel(
        namaLengkap: json.containsKey('NAMA_LGKP') ? ParseUtils.castString(json['NAMA_LGKP']) : null,
        statusHubunganKeluarga: json.containsKey('STAT_HBKEL') ? ParseUtils.castString(json['STAT_HBKEL']) : null,
        jenisPekerjaan: json.containsKey('JENIS_PKRJN') ? ParseUtils.castString(json['JENIS_PKRJN']): null,
        pendidikanAkhir: json.containsKey('PDDK_AKH') ? ParseUtils.castString(json['PDDK_AKH']) : null,
        tempatLahir: json.containsKey('TMPT_LHR') ? ParseUtils.castString(json['TMPT_LHR']) : null,
        statusKawin: json.containsKey('STATUS_KAWIN') ? ParseUtils.castString(json['STATUS_KAWIN']) : null,
        golonganDarah: json.containsKey('GOL_DARAH') ? ParseUtils.castString(json["GOL_DARAH"]) : null,
        nikIbu: json.containsKey('NIK_IBU') ? ParseUtils.castString(json['NIK_IBU']): null,
        tanggalKawin: json.containsKey('TGL_KWN') ? ParseUtils.castString(json['TGL_KWN']) : null,
        nomorAktaKawin: json.containsKey('NO_AKTA_KWN') ? ParseUtils.castString(json["NO_AKTA_KWN"]): null,
        jenisKelamin: json.containsKey('JENIS_KLMIN') ? ParseUtils.castString(json['JENIS_KLMIN']) : null,
        tanggalCerai: json.containsKey('TGL_CRAI') ? ParseUtils.castString( json['TGL_CRAI']) : null,
        nomorKK: json.containsKey('NO_KK')  ? ParseUtils.castString(json['NO_KK']) : null,
        nik: json.containsKey('NIK') ? ParseUtils.castString(json['NIK']) : null,
        kabupatenName: json.containsKey('KAB_NAME') ? ParseUtils.castString(json['KAB_NAME']) : null,
        namaLengkapAyah: json.containsKey('NAMA_LGKP_AYAH') ? ParseUtils.castString( json['NAMA_LGKP_AYAH']) : null,
        nomorRw: json.containsKey('NO_RW') ? ParseUtils.castString(json['NO_RW']) :null,
        kecamatanName: json.containsKey('KEC_NAME') ? ParseUtils.castString(json['KEC_NAME']):null,
        nomorRt: json.containsKey('NO_RT') ? ParseUtils.castString(json['NO_RT']) : null,
        nomorKelurahan: json['NO_KEL'],
        nomorKecamatan: json['NO_KEC'],
        alamat: json['ALAMAT'],
        nikAyah: json["NIK_AYAH"],
        nomorProvinsi: json['NO_PROP'],
        namaLengkapIbu: json['NAMA_LGKP_IBU'],
        nomorAktaCerai: json['NO_AKTA_CRAI'],
        provinsiName: json['PROP_NAME'],
        nomorKabupaten: json['NO_KAB'],
        tanggalLahir: json['TGL_LHR'],
        kelurahanName: json['KEL_NAME']);
  }
}