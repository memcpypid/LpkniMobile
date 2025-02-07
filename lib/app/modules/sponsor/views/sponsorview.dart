import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lpkni/app/modules/sponsor/controllers/sponsorcontroller.dart';

class SponsorView extends StatelessWidget {
  final SponsorController controller = Get.put(SponsorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title:
            Text("Form Sponsor", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Isi formulir untuk menghindari masalah selama sponsor",
                  style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16),
              _buildTextField(
                  "Nama Perusahaan", "Nama Anda", controller.companyName),
              _buildTextField(
                  "Jenis Produk", "Jenis Produk", controller.productType),
              _buildTextField(
                  "Tahun Penyewaan", "Tahun Anda", controller.rentalYear),
              _buildTextField("Alamat Email", "Email Anda", controller.email),
              SizedBox(height: 16),
              _buildFileUpload("Foto Iklan"),
              SizedBox(height: 16),
              _buildFileUpload("Surat Pernyataan Kesanggupan Sponsor",
                  showDownload: true),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text("CHAT", style: TextStyle(color: Colors.teal)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text("KIRIM", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, RxString controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 6),
        TextField(
          onChanged: (value) => controller.value = value,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }

  Widget _buildFileUpload(String label, {bool showDownload = false}) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.upload_file, color: Colors.teal),
                label: Text("Tambahkan File",
                    style: TextStyle(color: Colors.teal)),
              ),
              if (showDownload)
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(backgroundColor: Colors.teal),
                  child: Text("Download Surat",
                      style: TextStyle(color: Colors.white)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
