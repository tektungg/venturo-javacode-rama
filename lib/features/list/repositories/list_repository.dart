class ListRepository {
  // Dummy list of data
  final List<Map<String, dynamic>> data = [
    {
      "id_menu": 2,
      "name": "Chicken Slam ",
      "category": "food",
      "harga": 13000,
      "deskripsi":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.s",
      "foto": "https://javacode.landa.id/img/menu/gambar_62660e379fdf4.png",
      "status": 1
    },
    {
      "id_menu": 3,
      "name": "Lemon Tea",
      "category": "drink",
      "harga": 5000,
      "deskripsi": "Daun Teh dengan irisan lemon",
      "foto": "https://javacode.landa.id/img/menu/gambar_62660e379fdf4.png",
      "status": 1
    },
    {
      "id_menu": 12,
      "name": "Chicken Slam Noodles",
      "category": "food",
      "harga": 16000,
      "deskripsi": "as",
      "foto": "https://javacode.landa.id/img/menu/gambar_62660e47317ea.png",
      "status": 1
    },
    {
      "id_menu": 13,
      "name": "Fried Rice",
      "category": "food",
      "harga": 13000,
      "deskripsi": "fr",
      "foto": "https://javacode.landa.id/img/menu/gambar_62660ef6630d6.png",
      "status": 1
    },
    {
      "id_menu": 14,
      "name": "Fried Rice Noodles",
      "category": "food",
      "harga": 15000,
      "deskripsi": "frn",
      "foto": "https://javacode.landa.id/img/menu/gambar_62660f05b2072.png",
      "status": 1
    },
    {
      "id_menu": 15,
      "name": "Bebek Goreng",
      "category": "food",
      "harga": 24000,
      "deskripsi": "bg",
      "foto": "https://javacode.landa.id/img/menu/gambar_62660f2091f8c.png",
      "status": 1
    },
    {
      "id_menu": 16,
      "name": "Ayam Goreng",
      "category": "food",
      "harga": 15000,
      "deskripsi": "AG",
      "foto": null,
      "status": 1
    },
    {
      "id_menu": 17,
      "name": "Puyuh Goreng",
      "category": "food",
      "harga": 18000,
      "deskripsi": "PG",
      "foto": "https://javacode.landa.id/img/menu/gambar_62660f43c0542.png",
      "status": 1
    },
    {
      "id_menu": 18,
      "name": "Frieno Java Code",
      "category": "food",
      "harga": 13000,
      "deskripsi": "FJC",
      "foto": "https://javacode.landa.id/img/menu/gambar_62660f519a3fb.png",
      "status": 1
    },
    {
      "id_menu": 19,
      "name": "Grilled Sausage",
      "category": "food",
      "harga": 16000,
      "deskripsi": "Sosis Bakar",
      "foto": "https://javacode.landa.id/img/menu/gambar_62660f6f077fc.png",
      "status": 1
    },
    {
      "id_menu": 20,
      "name": "French Fries",
      "category": "food",
      "harga": 10000,
      "deskripsi": "Kentang Goreng Dengan Saus Yang Gokil",
      "foto": "https://javacode.landa.id/img/menu/gambar_62660f838c846.png",
      "status": 1
    },
    {
      "id_menu": 22,
      "name": "Potato Wedges",
      "category": "food",
      "harga": 12000,
      "deskripsi": "Racikan Kentang Dengan Bumbu Spesial Khas Java Code",
      "foto": "https://javacode.landa.id/img/menu/gambar_62660fa11c345.png",
      "status": 1
    },
    {
      "id_menu": 23,
      "name": "Sascram Eggs",
      "category": "food",
      "harga": 15000,
      "deskripsi": "Sosis Bakar Yang Di Padukan Dengan Olahan Telur Scribble",
      "foto": "https://javacode.landa.id/img/menu/gambar_6266100049ab0.png",
      "status": 1
    },
    {
      "id_menu": 24,
      "name": "Beef Burger",
      "category": "food",
      "harga": 14000,
      "deskripsi": "Burger Dengan Olahan Daging Sapi, Sayuran, Serta Keju",
      "foto": "https://javacode.landa.id/img/menu/gambar_62661010e0ef6.png",
      "status": 1
    },
    {
      "id_menu": 25,
      "name": "Nugget",
      "category": "food",
      "harga": 12000,
      "deskripsi": "NG",
      "foto": "https://javacode.landa.id/img/menu/gambar_62661020bdb0b.png",
      "status": 1
    },
    {
      "id_menu": 26,
      "name": "Maryam",
      "category": "food",
      "harga": 15000,
      "deskripsi": "Olahan Roti Khas timur tengah dengan topping coklat/Keju",
      "foto": "https://javacode.landa.id/img/menu/gambar_626611270bce4.png",
      "status": 1
    },
    {
      "id_menu": 27,
      "name": "V60",
      "category": "drink",
      "harga": 14000,
      "deskripsi": "Biji kopi arabika yang diolah menggunakan metode V60",
      "foto": "https://javacode.landa.id/img/menu/gambar_62661057cc43c.png",
      "status": 1
    },
    {
      "id_menu": 28,
      "name": "Tubruk",
      "category": "drink",
      "harga": 6000,
      "deskripsi": "Kopi Robusta Alami",
      "foto": "https://javacode.landa.id/img/menu/gambar_6266108602d08.png",
      "status": 1
    },
    {
      "id_menu": 29,
      "name": "Kopi Susu Strong",
      "category": "drink",
      "harga": 12000,
      "deskripsi": "Kopi Robusta, Susu Uht, Creamer, Kental Manis",
      "foto": "https://javacode.landa.id/img/menu/gambar_626610a407c58.png",
      "status": 1
    },
    {
      "id_menu": 30,
      "name": "Kopi Brown Sugar",
      "category": "drink",
      "harga": 12000,
      "deskripsi": "Kopi Robusta + Susu + Brown Sugar",
      "foto": "https://javacode.landa.id/img/menu/gambar_626610bc4165e.png",
      "status": 1
    },
    {
      "id_menu": 31,
      "name": "Coffee Beer",
      "category": "drink",
      "harga": 13000,
      "deskripsi": "Coffee beer olahan",
      "foto": "https://javacode.landa.id/img/menu/gambar_626610ce5de4c.png",
      "status": 1
    },
    {
      "id_menu": 32,
      "name": "Vietnam Drip",
      "category": "drink",
      "harga": 13000,
      "deskripsi":
          "Kopi Robusta, Kental Manis, Diolah Dengan metode khas Vietnam Drip",
      "foto": "https://javacode.landa.id/img/menu/gambar_625d150229656.png",
      "status": 1
    },
    {
      "id_menu": 33,
      "name": "Kopi Java Code",
      "category": "drink",
      "harga": 5000,
      "deskripsi": "50% Robusta 50%Arabika",
      "foto": "https://javacode.landa.id/img/menu/gambar_625d153f59b19.png",
      "status": 1
    },
    {
      "id_menu": 34,
      "name": "Kopi Susu Creamy",
      "category": "drink",
      "harga": 12000,
      "deskripsi": "Kopi Robusta Olahan, Susu UHT, Creamer, Kental Manis",
      "foto": "https://javacode.landa.id/img/menu/gambar_62661139ef69d.png",
      "status": 1
    },
    {
      "id_menu": 35,
      "name": "Long Black",
      "category": "drink",
      "harga": 13000,
      "deskripsi": "Kopi Robusta dengan metode Manual Brewing",
      "foto": "https://javacode.landa.id/img/menu/gambar_6266114e5b5fb.png",
      "status": 1
    },
    {
      "id_menu": 36,
      "name": "Choco Coffee Creamy",
      "category": "drink",
      "harga": 13000,
      "deskripsi": "Kopi susu creamy + Chocolate spesial",
      "foto": "https://javacode.landa.id/img/menu/gambar_626611611aa4d.png",
      "status": 1
    },
    {
      "id_menu": 37,
      "name": "Tea",
      "category": "drink",
      "harga": 3000,
      "deskripsi": "Daun Teh Pilihan",
      "foto": "https://javacode.landa.id/img/menu/gambar_626612ccd777e.png",
      "status": 1
    },
    {
      "id_menu": 38,
      "name": "Matcha Hot",
      "category": "drink",
      "harga": 11000,
      "deskripsi": "Greentea, Susu,Creamer",
      "foto": "https://javacode.landa.id/img/menu/gambar_625d1b75a4077.png",
      "status": 1
    },
    {
      "id_menu": 39,
      "name": "Ice Matcha",
      "category": "drink",
      "harga": 13000,
      "deskripsi": "Greentea, Susu,Creamer Ice",
      "foto": "https://javacode.landa.id/img/menu/gambar_626611abc99af.png",
      "status": 1
    },
    {
      "id_menu": 40,
      "name": "Dark Chocolate Hot",
      "category": "drink",
      "harga": 10000,
      "deskripsi": "Chocolate original + Susu ",
      "foto": "https://javacode.landa.id/img/menu/gambar_625d1b45adee8.png",
      "status": 1
    },
    {
      "id_menu": 41,
      "name": "Dark Chocolate Ice",
      "category": "drink",
      "harga": 12000,
      "deskripsi": "Chocolate original + Susu ",
      "foto": "https://javacode.landa.id/img/menu/gambar_626611ec41fb8.png",
      "status": 1
    },
    {
      "id_menu": 42,
      "name": "Strawberry Lava",
      "category": "drink",
      "harga": 12000,
      "deskripsi": "Selai strawberry + Susu strawberry",
      "foto": "https://javacode.landa.id/img/menu/gambar_6266120ada9ba.png",
      "status": 1
    },
    {
      "id_menu": 43,
      "name": "Susu Ovaltine",
      "category": "drink",
      "harga": 13000,
      "deskripsi": "Ovaltine+Susu",
      "foto": "https://javacode.landa.id/img/menu/gambar_6266121c02b28.png",
      "status": 1
    },
    {
      "id_menu": 44,
      "name": "Lemon Tea",
      "category": "drink",
      "harga": 5000,
      "deskripsi": "Daun teh irisan lemon",
      "foto": "https://javacode.landa.id/img/menu/gambar_62661234a177c.png",
      "status": 1
    },
    {
      "id_menu": 45,
      "name": "Blue Blood Ocean",
      "category": "drink",
      "harga": 13000,
      "deskripsi": "Jeruk Nipis, Coconut, Soda, Selasih",
      "foto": "https://javacode.landa.id/img/menu/gambar_626611fc53691.png",
      "status": 1
    },
    {
      "id_menu": 46,
      "name": "Blood Moon",
      "category": "drink",
      "harga": 13000,
      "deskripsi": "Jeruk Nipis, Coconut, Soda, Selasih",
      "foto": "https://javacode.landa.id/img/menu/gambar_6266123f80172.png",
      "status": 1
    },
    {
      "id_menu": 47,
      "name": "Orange Squash",
      "category": "drink",
      "harga": 12000,
      "deskripsi": "Jeruk,Soda, Selasih, irisan lemon",
      "foto": "https://javacode.landa.id/img/menu/gambar_6266124e669bc.png",
    },
    {
      "id_menu": 48,
      "name": "Jahe Merah",
      "category": "drink",
      "harga": 5000,
      "deskripsi": "Jahe Merah Tumbuk Hot",
      "foto": "https://javacode.landa.id/img/menu/gambar_6266125b05bc9.png",
    },
    {
      "id_menu": 52,
      "name": "empon empon",
      "category": "drink",
      "harga": 8000,
      "deskripsi": "ee",
      "foto": "https://javacode.landa.id/img/menu/gambar_626612746acd7.png",
    }
  ];

  // Get list of data
  Map<String, dynamic> getListOfData({int offset = 0}) {
    int limit = 99 + offset;
    if (limit > data.length) limit = data.length;

    return {
      'data': data.getRange(offset, limit).toList(),
      'next': limit < data.length ? true : null,
      'previous': offset > 0 ? true : null,
    };
  }

  // Delete item
  void deleteItem(int id) {
    data.removeWhere((element) => element['id_menu'] == id);
  }
}
