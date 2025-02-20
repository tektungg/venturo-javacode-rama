class OrderRepository {
  List<Map<String, dynamic>> ongoingOrder = [
    {
      "id_order": 35,
      "no_struk": "001/KWT/01/2022",
      "nama": "dev noersy",
      "total_bayar": 12000,
      "tanggal": "2023-06-19",
      "status": 2,
      "menu": [
        {
          "id_menu": 9,
          "kategori": "makanan",
          "nama": "Nasi Goreng",
          "foto": "https://i.ibb.co/mRJnq3Z/nasi-goreng.jpg",
          "jumlah": 1,
          "harga": "10000",
          "total": 10000,
          "catatan": "test"
        }
      ]
    },
    {
      "id_order": 133,
      "no_struk": "001/KWT/02/2022",
      "nama": "admin",
      "total_bayar": 31000,
      "tanggal": "2022-02-18",
      "status": 1,
      "menu": [
        {
          "id_menu": 2,
          "kategori": "makanan",
          "topping": "[]",
          "nama": "Chicken Slam ",
          "foto": "https://i.ibb.co/R9kJtny/1637916829.png",
          "jumlah": 1,
          "harga": "19000",
          "total": 19000,
          "catatan": "\"\""
        },
        {
          "id_menu": 4,
          "kategori": "makanan",
          "topping": "[]",
          "nama": "Chiken Katsu",
          "foto": "https://i.ibb.co/R9kJtny/1637916829.png",
          "jumlah": 1,
          "harga": "12000",
          "total": 12000,
          "catatan": "\"\""
        }
      ]
    },
    {
      "id_order": 134,
      "no_struk": "002/KWT/02/2022",
      "nama": "admin",
      "total_bayar": 22400,
      "tanggal": "2022-02-18",
      "status": 0,
      "menu": [
        {
          "id_menu": 11,
          "kategori": "minuman",
          "topping": "",
          "nama": "Es Buah",
          "foto": "https://javacode.landa.id/img/menu/gambar_620e4ee227013.png",
          "jumlah": 1,
          "harga": "8000",
          "total": 8000,
          "catatan": "\"\""
        },
        {
          "id_menu": 10,
          "kategori": "minuman",
          "topping": "",
          "nama": "Es Teller 666",
          "foto": "https://javacode.landa.id/img/menu/gambar_620df18327cde.png",
          "jumlah": 1,
          "harga": "10000",
          "total": 10000,
          "catatan": "\"\""
        },
        {
          "id_menu": 3,
          "kategori": "minuman",
          "topping": "[1,2]",
          "nama": "Lemon Tea",
          "foto": "https://javacode.landa.id/img/menu/gambar_62660e379fdf4.png",
          "jumlah": 1,
          "harga": "16000",
          "total": 16000,
          "catatan": "\"\""
        }
      ]
    },
    {
      "id_order": 135,
      "no_struk": "003/KWT/02/2022",
      "nama": "admin",
      "total_bayar": 10400,
      "tanggal": "2022-02-18",
      "status": 2,
      "menu": [
        {
          "id_menu": 9,
          "kategori": "makanan",
          "topping": "[]",
          "nama": "Nasi Goreng",
          "foto": "https://i.ibb.co/KNxRXBN/1637916792.png",
          "jumlah": 1,
          "harga": "10000",
          "total": 10000,
          "catatan": "\"\""
        },
        {
          "id_menu": 3,
          "kategori": "minuman",
          "topping": "[]",
          "nama": "Lemon Tea",
          "foto": "https://javacode.landa.id/img/menu/gambar_62660e379fdf4.png",
          "jumlah": 1,
          "harga": "12000",
          "total": 12000,
          "catatan": "\"\""
        }
      ]
    },
  ];

  // Get Ongoing Order
  List<Map<String, dynamic>> getOngoingOrder() {
    return ongoingOrder.where((element) => element['status'] < 3).toList();
  }

  // Get Order History
  List<Map<String, dynamic>> getOrderHistory() {
    return ongoingOrder.where((element) => element['status'] > 2).toList();
  }

  // Get Order Detail
  Map<String, dynamic>? getOrderDetail(int idOrder) {
    return ongoingOrder.firstWhere((element) => element['id_order'] == idOrder,
        orElse: () => {});
  }
}
