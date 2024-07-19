import 'package:flutter/material.dart';
import 'package:mobile_gmf/Theme.dart';

class settingsPage extends StatefulWidget {
  const settingsPage({super.key});

  @override
  State<settingsPage> createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: greenColor,
          title: Text('Informasi Status Kualitas Udara',
              style: whitekTextStyle.copyWith(
                  fontSize: 16, fontWeight: FontWeight.bold)),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: whiteColor,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                
                Text('0.0 - 0.33 Normal\nKualitas udara berada dalam kondisi yang baik. Tingkat polusi udara sangat rendah dan tidak ada atau sangat sedikit partikel berbahaya yang terdeteksi. Risiko terhadap kesehatan sangat minimal, baik untuk mahluk hidup.'),
                SizedBox(
                  height: 10,
                ),
                Text('0.34 - 0.66 Cukup\nKualitas udara berada pada tingkat sedang. Terdapat peningkatan jumlah partikel polusi di udara, namun masih dalam batas toleransi untuk kebanyakan orang. Dianjurkan untuk membatasi aktivitas fisik yang berat di luar ruangan.'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '0.67 - 1.0 Bahaya\nKualitas udara buruk dan berbahaya. Tingkat polusi udara sangat tinggi, mengandung partikel dan zat berbahaya yang dapat menyebabkan masalah kesehatan serius. Paparan terhadap kondisi ini dapat menyebabkan efek kesehatan yang serius.')
              ],
            ),
          ),
        )
        );
  }
}
