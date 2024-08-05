// ignore_for_file: file_names

class ApiConnect {
  static const host = "https://is4ac.research-ai.my.id/";
  static const hostConnect = '$host' + "api";

  static const register = "$hostConnect/register_customer";

  static const checkEmail = "$hostConnect/check_email";

  static const login = "$hostConnect/login";

  static const image = "$hostConnect/images";

  static const rekap = "$hostConnect/rekap";

  static const berita = "$hostConnect/berita";

  static const datadomba = "$hostConnect/domba_trading_tersedia";

  static const datadombabreeding = "$hostConnect/paket_breeding";

  static const dataKamar = "$hostConnect/kamar_transaksi";

  static const dataPlasma = "$hostConnect/getPlasma";

  static const updateCustomer = "$hostConnect/updateCustomer";

  static const updatePassword = "$hostConnect/updatePassword";

  static const checkDataKamar = "$hostConnect/update_kamar_tidak_tersedia";

  static const riwayatDiajukan = "$hostConnect/riwayat_diajukan";

  static const riwayatDiproses = "$hostConnect/riwayat_diproses";

  static const riwayatDitolak = "$hostConnect/riwayat_ditolak";

  static const riwayatSelesai = "$hostConnect/riwayat_selesai";

  static const transaksi = "$hostConnect/transaksi";

  static const dombaSaya = "$hostConnect/domba_saya";

  static const filterDomba = "$hostConnect/filter_domba_trading";

  static const filterJenisDomba = "$hostConnect/jenis_domba";
}
