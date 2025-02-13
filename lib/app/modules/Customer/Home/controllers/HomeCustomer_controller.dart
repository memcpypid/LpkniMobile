import 'package:get/get.dart';
import 'package:lpkni/app/data/Customer/Model/food_model.dart';
import 'package:lpkni/app/data/Customer/Model/news_model.dart';
import 'package:lpkni/app/modules/Customer/Cart/controllers/cartCustomer_controller.dart';

class HomecustomerController extends GetxController {
  final CartcustomerController cartController =
      Get.find<CartcustomerController>();
  var newsList = <News>[].obs;
  var selectedNews = Rxn<News>(); // ✅ Berita yang sedang ditampilkan
  var newProducts = <FoodItem>[].obs;
  var bestSellers = <FoodItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
    loadNews();
  }

  Future<void> refreshData() async {
    // Simulasi delay saat mengambil data
    await Future.delayed(const Duration(seconds: 2));

    // Panggil ulang data dari controller atau API
    loadProducts(); // Jika menggunakan controller
    loadNews(); // Jika ada berita
  }

  void loadNews() {
    newsList.assignAll([
      News(
        title: "Kondisi Dapur Pak Muh",
        description:
            "Dapur adalah salah satu bagian terpenting dalam sebuah rumah, tempat di mana makanan disiapkan dan disajikan untuk keluarga. "
            "Namun, sering kali kebersihan dapur diabaikan, yang dapat menyebabkan berbagai masalah kesehatan dan kebersihan. "
            "Dalam kasus dapur Pak Muh, kondisi dapur yang berantakan dan penuh dengan sisa makanan yang belum dibersihkan menjadi perhatian utama. "
            "Sisa makanan yang dibiarkan di wastafel dapat menjadi tempat berkembang biaknya bakteri dan serangga seperti kecoa dan tikus. "
            "Untuk menjaga kebersihan dapur, sangat penting untuk segera mencuci peralatan masak setelah digunakan, membuang sampah dengan benar, "
            "dan memastikan tidak ada sisa makanan yang dibiarkan terlalu lama. "
            "Dengan menjaga kebersihan dapur, kita bisa memastikan makanan yang dikonsumsi tetap sehat dan aman bagi seluruh anggota keluarga.",
        image: "assets/news/news1.png",
        author: "Admin Berita",
        date: "10 Februari 2024",
        time: "08:30",
        isPopular: true,
      ),
      News(
        title: "Tips Memasak Sehat untuk Keluarga",
        description:
            "Memasak sehat bukan hanya tentang memilih bahan makanan yang bergizi, tetapi juga memperhatikan teknik memasak yang dapat menjaga nutrisi makanan tetap terjaga. "
            "Beberapa tips memasak sehat yang bisa diterapkan di rumah antara lain: \n\n"
            "1. **Gunakan Minyak Sehat** – Hindari minyak yang tinggi lemak jenuh dan gunakan minyak zaitun, minyak kelapa, atau minyak biji bunga matahari sebagai alternatif yang lebih sehat.\n"
            "2. **Hindari Gorengan Berlebihan** – Sebisa mungkin, pilih metode memasak seperti merebus, mengukus, atau memanggang yang lebih sehat dibandingkan menggoreng dengan banyak minyak.\n"
            "3. **Konsumsi Sayur dan Buah Segar** – Pastikan setiap hidangan mengandung sayur dan buah yang cukup untuk menjaga asupan serat dan vitamin dalam tubuh.\n"
            "4. **Kurangi Garam dan Gula Berlebih** – Gunakan rempah-rempah alami untuk menambah cita rasa makanan daripada menambahkan garam atau gula dalam jumlah berlebihan.\n"
            "5. **Perhatikan Kebersihan** – Cuci tangan sebelum dan setelah memasak, serta pastikan peralatan dapur selalu bersih agar makanan tetap higienis.\n\n"
            "Dengan menerapkan tips memasak sehat ini, Anda bisa memastikan bahwa makanan yang disajikan untuk keluarga tetap bernutrisi, sehat, dan lezat.",
        image: "assets/news/news1.png",
        author: "Chef Dapur Sehat",
        date: "9 Februari 2024",
        time: "10:00",
      ),
      News(
        title: "Rahasia Membuat Rendang yang Empuk dan Lezat",
        description:
            "Rendang adalah salah satu masakan khas Indonesia yang sudah mendunia. Dikenal dengan cita rasa yang kaya akan rempah-rempah, "
            "rendang membutuhkan teknik memasak yang tepat agar menghasilkan daging yang empuk dan bumbu yang meresap sempurna. "
            "Berikut adalah beberapa rahasia membuat rendang yang lezat:\n\n"
            "1. **Pilih Daging Berkualitas** – Gunakan daging sapi bagian paha atau sandung lamur yang memiliki tekstur empuk dan cocok untuk dimasak dalam waktu lama.\n"
            "2. **Gunakan Santan Segar** – Santan kental dari kelapa segar akan memberikan rasa gurih yang lebih nikmat dibandingkan santan instan.\n"
            "3. **Masak dengan Api Kecil** – Rendang dimasak dalam waktu yang lama dengan api kecil agar bumbu meresap sempurna dan daging menjadi lebih empuk.\n"
            "4. **Gunakan Rempah Asli** – Rempah seperti lengkuas, serai, daun kunyit, dan cabai merah harus dihaluskan dan dimasak hingga harum sebelum dicampurkan dengan daging.\n"
            "5. **Aduk Sesekali, Jangan Terlalu Sering** – Aduk rendang sesekali agar tidak gosong, tetapi jangan terlalu sering mengaduk karena bisa membuat daging hancur.\n\n"
            "Dengan mengikuti langkah-langkah di atas, Anda bisa membuat rendang yang empuk, kaya rasa, dan lezat seperti di restoran Padang favorit Anda!",
        image: "assets/news/news1.png",
        author: "Kuliner Nusantara",
        date: "8 Februari 2024",
        time: "14:15",
      ),
      News(
        title: "Pentingnya Menjaga Pola Makan Seimbang",
        description:
            "Di era modern seperti sekarang, pola makan sering kali diabaikan karena kesibukan dan gaya hidup yang serba cepat. "
            "Namun, pola makan yang seimbang sangat penting untuk menjaga kesehatan tubuh dan mencegah berbagai penyakit kronis seperti diabetes, hipertensi, dan obesitas. "
            "Pola makan yang sehat mencakup kombinasi antara karbohidrat, protein, lemak sehat, serta vitamin dan mineral yang diperoleh dari berbagai jenis makanan.\n\n"
            "Beberapa kebiasaan baik yang bisa diterapkan untuk menjaga pola makan seimbang adalah:\n"
            "- **Sarapan dengan Nutrisi Lengkap** – Pastikan sarapan mengandung protein, serat, dan karbohidrat yang cukup untuk energi sepanjang hari.\n"
            "- **Kurangi Konsumsi Makanan Olahan** – Makanan olahan cenderung mengandung bahan tambahan yang tidak sehat seperti pengawet, pewarna, dan pemanis buatan.\n"
            "- **Perbanyak Minum Air Putih** – Minum air yang cukup membantu menjaga keseimbangan cairan tubuh dan meningkatkan metabolisme.\n"
            "- **Makan dengan Porsi yang Wajar** – Hindari makan berlebihan dan biasakan makan dalam porsi kecil tetapi sering untuk menghindari lonjakan gula darah.\n\n"
            "Dengan menjaga pola makan yang sehat, Anda dapat meningkatkan kualitas hidup dan menjaga kesehatan tubuh dalam jangka panjang.",
        image: "assets/news/news1.png",
        author: "Ahli Gizi Indonesia",
        date: "7 Februari 2024",
        time: "11:45",
      ),
    ]);
  }

  void loadProducts() {
    newProducts.assignAll([
      FoodItem(
        name: "Rendang Jengkol",
        price: "Rp17.000",
        image: "assets/food/food1.png",
        Desc:
            "Jengkol empuk dengan bumbu rendang khas Padang yang kaya rempah, menggugah selera.",
        rating: 4.2,
        soldCount: 150,
      ),
      FoodItem(
        name: "Sate Pak Muh",
        price: "Rp20.000",
        image: "assets/food/food1.png",
        Desc:
            "Sate ayam dengan bumbu kacang kental, dipanggang dengan arang untuk cita rasa khas.",
        rating: 4.8,
        soldCount: 230,
      ),
      FoodItem(
        name: "Sate Pak Muh",
        price: "Rp20.000",
        image: "assets/food/food1.png",
        Desc:
            "Daging yang lembut dan bumbu khas, membuat sate ini jadi favorit banyak orang.",
        rating: 4.6,
        soldCount: 200,
      ),
    ]);

    bestSellers.assignAll([
      FoodItem(
        name: "Rendang Jengkol Mantap Enak Boy Enak Sekali hahahaha",
        price: "Rp17.000",
        image: "assets/food/food1.png",
        Desc:
            "Jengkol yang dimasak perlahan dalam bumbu rendang kaya rempah, menggoda lidah.",
        rating: 4.3,
        soldCount: 180,
      ),
      FoodItem(
        name: "Sate Pak Muh",
        price: "Rp20.000",
        image: "assets/food/food1.png",
        Desc:
            "Sate ayam yang lezat, disajikan dengan saus kacang kental dan lontong.",
        rating: 4.7,
        soldCount: 250,
      ),
      FoodItem(
        name: "Gado Gado",
        price: "Rp11.000",
        image: "assets/food/food1.png",
        Desc:
            "Salad khas Indonesia dengan aneka sayuran segar, disiram saus kacang gurih.",
        rating: 4.5,
        soldCount: 190,
      ),
      FoodItem(
        name: "Soto Bu Ida",
        price: "Rp12.000",
        image: "assets/food/food1.png",
        Desc:
            "Kuah kuning gurih dengan suwiran ayam, bihun, dan taburan bawang goreng.",
        rating: 4.6,
        soldCount: 220,
      ),
      FoodItem(
        name: "Gudeg",
        price: "Rp15.999",
        image: "assets/food/food1.png",
        Desc:
            "Nangka muda yang dimasak dengan santan, manis dan gurih, khas Yogyakarta.",
        rating: 4.4,
        soldCount: 210,
      ),
      FoodItem(
        name: "Nasi Goreng",
        price: "Rp11.000",
        image: "assets/food/food1.png",
        Desc:
            "Nasi goreng spesial dengan bumbu khas, dilengkapi dengan telur mata sapi.",
        rating: 4.3,
        soldCount: 300,
      ),
      FoodItem(
        name: "Rendang Paru",
        price: "Rp15.000",
        image: "assets/food/food1.png",
        Desc:
            "Paru sapi empuk yang dimasak dalam bumbu rendang kental, kaya rasa.",
        rating: 4.5,
        soldCount: 170,
      ),
      FoodItem(
        name: "Mie Aceh",
        price: "Rp12.000",
        image: "assets/food/food1.png",
        Desc:
            "Mie tebal dengan kuah kari kental dan rempah-rempah khas Aceh, pedas dan nikmat.",
        rating: 4.6,
        soldCount: 200,
      ),
    ]);
  }
}
