import 'package:venturo_core/features/checkout/constants/checkout_api_constant.dart';

class VoucherRepository {
  VoucherRepository();

  var apiConstant = CheckoutApiConstant();

  Future<List<Map<String, dynamic>>> fetchVouchers() async {
    // Dummy data
    return [
      {
        "id_voucher": 15,
        "nama": "Friend Referral Recruitment",
        "nominal": 187000,
        "info_voucher":
            "https://javacode.landa.id/img/promo/gambar_62661b52223ff.png",
        "periode_mulai": "2022-04-18",
        "periode_selesai": "2022-05-18",
        "type": 0,
        "status": 0,
        "catatan":
            "<p>Teman mu disini karena Mu, terima kasih atas dedikasi menyebarkan informasinya</p>"
      },
      {
        "id_voucher": 16,
        "nama": "For Being the Most Active duri",
        "nominal": 40000,
        "info_voucher":
            "https://javacode.landa.id/img/promo/gambar_62661b96dad9d.png",
        "periode_mulai": "2022-04-18",
        "periode_selesai": "2022-04-25",
        "type": 0,
        "status": 0,
        "catatan":
            "<p>Nah gitu dong, terus aktif ya pada saat Training</p><p>Semoga ilmu yang dipelajari bermanfaat bagi pengembangan dirimu</p>"
      },
      // Tambahkan data dummy lainnya jika diperlukan
    ];
  }
}
